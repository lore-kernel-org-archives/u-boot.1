Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCBFC624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 12:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A487C60B6E;
	Thu,  3 Sep 2026 12:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbrXkZ-IkmCb; Thu,  3 Sep 2026 12:51:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D956560B6B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788439860;
	b=D5NM48JEAldEJebKr+RCn2aQ5t084wFwtCoupRludz+BWwnVK2NkRRWIkVA6EGQbIoI0
	 QkVPEJf4m+q0tqKYi6egAGYtULpYJB43X1KFqBbvU1sANREhiKVyl0vIxjKTV80LraBUd
	 k2rSqqlMxsCl4G4NlM8o9dTm9hKoaonyZfVqIDVFJq2w4qIMRtMBLeeIAe853egCw3bZD
	 pmLwpujYmBUBm9JAwtv0m+Q31uA5Nv9vBq7MdPnyFvJmmK4HV1H/YiuRhf1tpQSaLtIvl
	 tiVYpEiQ4A7/0PXBcPBKxj9mqP0vR375S2uluHyPeTZaWLNyuW/V93icrhxVII6sGyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788439860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=apdgHh6KsuZDM8hU82RpHlOLGgLH8tIFjJ7ggi1zRAU=;
	b=Eg2NkW6GWnOzOeQpgkJid+BU/y5+kHWNMkOmVv4Z3XRePlAhSAXrjKfCDsjSoM7E2LHD
	 D/r3uOqxYYztt0fZ5fRPko28Bukx2CCJ5MCrOdD+ktidWC44zIrewIdqDWMuRYPQud/F8
	 gRKDgh1qFvQ1cWeVl0We1vjLUsEXCrvZ1xiIV0Gr68obZ57ASJPyht9HZVRMmNfHM065/
	 fwpXyaefK4EIafdyXqwS06W0NnnKouckxpiVgdCjGgw/3P2zQzknkljAD4RnFQhXycj/G
	 pRbomSVS1IauJ6sXcZFs3ZTHHlceiAgc4b5FgMIz20TkpUakiCWOF90vgeUFeuACYlw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788439860;
	bh=apdgHh6KsuZDM8hU82RpHlOLGgLH8tIFjJ7ggi1zRAU=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kQvpQpOngbheF6ISLAzcVrSDlZxmTpUp2kD4/TYoWAMJ8F/2HViXN5QMsU5gdGIOp
	 3vPHWtl2SNSr++P+kFtPTsbnQ4Licu/gV+GIWrhOfmGv3a1JlarACigiwXknkO13To
	 x7gpUgAwk46MxVP3QvGkBjHoQR5cKYyWI7vHnYC5g0FH7H0uJva6XtLrWnU/YxUvg9
	 5Y9PR99cqcgsDswMInHHq6hbTMWgdHFC/0VkXSMyaCXDZVOShkH5KQAzpq7vHrlxZ2
	 BNmLhBDldYnU8V8Y5G4NOhetq0QmWP8JYwqHrlGFxneMuTattrF5sJlTzQiIp6eOAs
	 9/o+wdmzTcARg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D956560B6B;
	Thu,  3 Sep 2026 12:50:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C2997498
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 00:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A047740177
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 00:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QLsS0igjvz5M for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 00:30:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8595E40063
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788395411;
 b=Eo8zwCTEnPbIXb3ld4iDz0HLN3m3MtcFG9nvBuqiyahm8FRjZPZ9jA3rEIDwZaFsLpIy
 eTXB171j7Ln5+Nsj5x/sRE2uv2VMexSH6k3B6n/Yo8b6rX+KcSIYZkFchWSFOuh2I6Yl3
 ZFNPdKYxeP3AyMe7zSVmTlnVZw5P5lFBqxkHtcf1T+htwsq0nzxN3Mysm3ONSN1rwKkIG
 lRdoAiEFyxyLFlGG0uFzg6HnyfZ3exZfGavs168qnUb/SCxIMcj/N6M03qtX0sjtgHlMd
 +Epo9k01hEytCFPLIUCPPS3OSSNS6joUf9d4efk9/cZdPQ3wL/7xA609izstwpWNK/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788395411;
 h=X-Greylist:Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:
 Message-ID:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=apdgHh6KsuZDM8hU82RpHlOLGgLH8tIFjJ7ggi1zRAU=;
 b=XBJWa3bifPJYZdFjkFpQ0B6hPJrF3sr943r7fcktbEpxBihEARyFGJcqyNbWubQVOB9A
 x6QGA2mZ3Gvpw1e2TFaOV2U6OTWDUsh8k8SfBnyzoqE3IM1bf/IPdk0gIz36GKLlYoMWU
 LrZYSA9urErnDd5Awb0hh9kWhKDXB+R0BopPjt2MueEH9S54HNGnZkKWCSquFSwHbIC86
 UKOHpIS+fYw2K0Pd+dSluuRDDZeBly78S/MBG76Gq29k7K7Bxdc0fqH6TZiAj5YhPvIw2
 v1Z6FAUzMqOM7OVx0WfPbC7BRk7ArT741gdCOKl5ZjFqVPPREaQDRV51NvjOtgE1Wdw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; dmarc=pass header.from=pm.me;
 dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256
 header.s=protonmail3 header.b=MVOXTYvn; 
 arc=none smtp.remote-ip=85.9.210.45
X-Greylist: delayed 57901 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 03 Sep 2026 00:30:11 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256
 header.s=protonmail3 header.b=MVOXTYvn
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=mcpratt@pm.me; receiver=<UNKNOWN> 
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8595E40063
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 00:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1788395403; x=1788654603;
 bh=apdgHh6KsuZDM8hU82RpHlOLGgLH8tIFjJ7ggi1zRAU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=MVOXTYvnkBkv2qRXH+KwDPm8ewl9hftJqDJu2GkGwlvxrwRJpNGovlJrUXCFd8xxO
 1swAjiibPkZkzFNuvPidi7c/+O8as48wpQ9grFpFw6TgaMa1z4pVw49KwzE2tzYruP
 XjAZY33c/P+9sql+xnEbZgvIBlSJZLbOzaLGD9cgryj8IrFaselLsbcOEe2WzRN2Pi
 +BzsdYWJyPvmAdsT7wy4H7Ww/iJRhcxEvNuMRwwAaIdqK5N7+IPXzLn8KECFow8kjz
 Kidj7IAgxtkG2MhvpYN7M8mZhapYZ2RJOg24vXJu0Rvd5qENIxsjBfZz9I8xvJtE0i
 /6Qbo3Nua58ag==
Date: Thu, 03 Sep 2026 00:29:58 +0000
To: u-boot@lists.u-boot-project.org
From: "Michael C. Pratt" <mcpratt@pm.me>
Cc: "Michael C. Pratt" <mcpratt@pm.me>, Tom Rini <trini@konsulko.com>,
 =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2] fw_env: use env-size property for nvmem layout device
 detection
Message-ID: <20260903002942.7835-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: 06e958619b206db4058e30f995ebc1552f7c0aa0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Sep 2026 12:50:58 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Since Linux commit 5b2f8c133d98 ("nvmem: layouts: u-boot-env:
add optional "env-size" property"), there is support for providing the size
of the u-boot environment used by the bootloader to the layout NVMEM driver
in order to calculate the CRC if the range is less than the partition size
in a similar fashion that it would be provided in a fw_env.config file.

Devicetree binary cells are always stored in big-endian,
so endian translation is now necessary for this case.

Reuse the buffer that holds the path for opening the compatible sysfs file
for parsing this env-size property and possibly more in the future,
as soon as the correct device is identified with the compatible property.

Signed-off-by: Michael C. Pratt <mcpratt@pm.me>
---
 tools/env/fw_env.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index 8810b0e94dc..7dd90b16b46 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -30,6 +30,7 @@
 #include <u-boot/crc.h>
 #include <unistd.h>
 #include <dirent.h>
+#include <asm/byteorder.h>
=20
 #ifdef MTD_OLD
 # include <stdint.h>
@@ -1714,6 +1715,7 @@ static int find_nvmem_device(void)
 =09char comp[256];
 =09char buf[32];
 =09int bytes;
+=09ulong layout_size =3D 0;
 =09DIR *dir;
=20
 =09dir =3D opendir(path);
@@ -1771,6 +1773,9 @@ static int find_nvmem_device(void)
 =09=09=09}
 =09=09}
=20
+=09=09/* Remember the nvmem device path for parsing other properties. */
+=09=09bytes =3D snprintf(comp, sizeof(comp), "%s/%s", path, dent->d_name);
+
 next:
 =09=09fclose(fp);
 =09}
@@ -1779,6 +1784,8 @@ next:
=20
 =09if (nvmem) {
 =09=09struct stat s;
+=09=09FILE *fp;
+=09=09size_t size;
=20
 =09=09stat(nvmem, &s);
=20
@@ -1786,6 +1793,20 @@ next:
 =09=09DEVOFFSET(0) =3D 0;
 =09=09ENVSIZE(0) =3D s.st_size;
=20
+=09=09if (bytes > 0 && bytes < sizeof(comp)) {
+=09=09=09strcat(comp, "/of_node/nvmem-layout/env-size");
+=09=09=09fp =3D fopen(comp, "rb");
+=09=09=09if (fp) {
+=09=09=09=09fstat(fileno(fp), &s);
+=09=09=09=09size =3D fread(&layout_size, s.st_size, 1, fp);
+=09=09=09=09if (size =3D=3D 1)
+=09=09=09=09=09ENVSIZE(0) =3D __be32_to_cpu(layout_size);
+=09=09=09=09fclose(fp);
+=09=09=09}
+
+=09=09=09comp[bytes] =3D '\0';
+=09=09}
+
 =09=09return 0;
 =09}
=20
--=20
2.30.2


