Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB7D606A33C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u+tlouxw;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZA0aA5bA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4D8E60AA7;
	Thu, 26 Nov 2026 13:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CabcUrVd0kBn; Thu, 26 Nov 2026 13:33:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 059B560AAD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700026;
	b=PQJdeVvsESW9n3S6P1umzzvsKI2lE0cdd8B2PKL43iv5v+bbLtvloj/gxnr6YuUrYBka
	 YOA46mWLHEBPTJzTnxnOEwb8FOnDkh91PFFD133qKnN1Nwa+O5gG11qmbABanXDzAPo/6
	 GKc8IXESC7fk59Y6oFWoFp3CRBDqfV/pfeJuUIDKQJlw4syad76NG+Ct+R6kjmnciearr
	 oFcThHd0SE65BJMX7pENP/oL7GajHdPmV3NsYDrhrcLJlV/wsmWHA+g/MiPzZ4tG+GiNn
	 M5kDvhLXsfr1NgYTJFK9kUGb3Qkj4/ZZnRSuxsIAWggxQum2FuAMply/FO2VfdCuPJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hTjD4lX11QzxuWko98C7FiXQ2ZOdL4zLjr1ZIoRc6PA=;
	b=S16KqH0sn7k0bly1MLqXe9aWp9MP9txdzi99dHA2fiefLILscRDVNcM+E9ES4j0R1KQm
	 oZjdWVs9GR17+d8vRqL8hIZRApr9LiQ6HsAIUFJ4ZMfMTwUDgFWb0UwTvx9hfELQrGtsE
	 kISF1djmDSD2NeGyBr3dPdl1qrAVCQIB87n2GZ31CwYOW+13O7PODsUu7Vn8nw3ykqj3W
	 XTt214CsNg8X5XdO2SJCudyhIiywe3obyiZHKyQhg81luhJwLIblXY5KBv3tgyT7BQT53
	 ceQ8Xl9+IoCVZy9TO4zbOFZTxR/B5jg1IpPeBqzZuO2GT7w1XqPvGjAmmxEgbIhDADA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZA0aA5bA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700026;
	bh=hTjD4lX11QzxuWko98C7FiXQ2ZOdL4zLjr1ZIoRc6PA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u+tlouxw0bJOn3cE/FC51/+sSIdt9Rytdy3xAWF3VstDT14XOa54z+RE7BKF7lF8Y
	 o2GlRmw0eNX7ciMWLaQkI9fiQrFPK3URHPwoR/tdqF/fLiE70coxLIcbS4gkbnHroB
	 iw5/hZPyeJy+CK6GV0WLwnD6XL0Rt5761wTEOsP+TfHjaG9mCXZ7D/AYmY6fUMg0J/
	 2j8cjKCryhC31kMBzPS3cqhEcmxpYnNzQVWhw/uR8XSelAYx4ObwsiXFYLWR56gZY5
	 Px4T9Twa1AQyOpn9D5rF8qY8neIucVQe2jexQE397YyZp2YG0vOk04OuMTIWAMXJWy
	 zPDXlD0K328Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 059B560AAD;
	Thu, 26 Nov 2026 13:33:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A3A0222B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89239608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X4dhJy60QKun for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CA0E2608AE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ZA0aA5bA
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA0E2608AE
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:38 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-8470d7d430fso3330750a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676017; x=1796280817;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hTjD4lX11QzxuWko98C7FiXQ2ZOdL4zLjr1ZIoRc6PA=;
 b=ZA0aA5bAJtvTEi3Rs26+plxDchyuB1smAmpa5bIViEeZsis4yHdkF9mMHJMFdDFx3k
 OWkgDpGhwuvErfmrmnD2APdLuqn1xhi6ET2PXG4hX/N2Z9XhJbFTXKenRuP2wdiAqpNe
 iDlQd8gDd7BqHXDKYs6nWyeveFSUHQyyYn/D0TO5ZIaYzoAQpdxEyRBWHwe/xJ09h4GG
 YQiu5J8P4F1eocrfcqk8WNTLnaLkS5CsG2p1e/RRqpiCQLXCjlqih3MKss67dDm9oVg7
 /RJLeP1Z5I5oaabHgtHQGoZoLWrBzCpJYKYF27oSlO69pHDzzvy+JVkIWZXDUzVDLqvs
 15gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676017; x=1796280817;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hTjD4lX11QzxuWko98C7FiXQ2ZOdL4zLjr1ZIoRc6PA=;
 b=ByZv5DzLF25JsmftjHQiF0PJGP8nSjwqOXPoQQL6Oe4mpyQAxUphez1N2intOixS9o
 3kA157v0Ggr2p/VobRwwWKug4Edp+HQRSnUUuMGBBeMIqn9jp73PvpYGBvAt/mqTfwgF
 cjYmc7OCdYVgfvLXR3bm8vu56JDSDkSRlnv8uRvFz82sJno4ZQOvJTXo9jy0oJm5VW1y
 LwnZj1eMjEIIMlU5jgwXyBJJYz1PVXFLZ9ed8JDlkDUQY6lBIkpykU7uYT0Om0DpqySZ
 xJXTONmxLa06UctaCFCa7umrtZtm+KLLg96cy9Epp5/Xh+ARTZKrY/B6L6f1nr75oe5+
 PioA==
X-Gm-Message-State: APuU4Z/HidUWj83hIpDiFem8VPUvjq5PhzwOMGHoVrTnknn943FuZjub
 tyqJRCHnfk4e+zIizi/486gvAySlzaMWD6dIUwPuy5fupaRw8nsG/aMD
X-Gm-Gg: AZFdTZd/qn1K6Bl/A/7CUx19MFrc0o5mQl7wEJEJHtFkJ7NIP5WURpcTe4A0wQO73bV
 ZmWbmB3ah1R2DO8qHA0yzZAi+/vKEFhLSfF6vLi+Vm1xRC2rlWoH5I+Qmz7Apf5VGKsFMxbR9md
 Zz/3gnBT4+yLKaNxZGePTASQCvYfSy+93RdhWxIkW0AfHxpoHsEApCMkMHJrrJ/gIEnd+r7Qci6
 U3XEoUal0OPjVWfHqnm2ad33Bemv1xI4igcTh3G3c3qD5Jg3BUp90ANm7RnoXO+QYF2fBirSSEy
 9E5A8c8IO5JoQ7Rp5LMCSgFrAhlfBGtnbP29YT80sq7Hdnsajo2NmYjYcc3Q2nNPXRnjpQFJlCz
 uuOm4CzlAB8QGfSf+6E+vQG29VOqdAVToGg+s8CJQCduYP96jb22qizYrrbEZeVSWiKPYXznz03
 ae1GfUWRNSZnkdT5Av0Aqw2PZxIYFCF/QhbECLGO0XwanKbGiZGjYmDCcQdRPfSgNh6o7JvMRe5
 C0qjUMKfeuAtziDRqI8/4fi/DnSEMC9tovF/hKNjkfA7b/TU6iSRkRFtYLTjnSq2RgEKYiy0Mk6
 c43GlgXBuRySMyLSY+Q1oV773wjTCPAzHpm02Fh/j0konhpPy2nh0zxI9HxDr+/RTspvlMFA86N
 LQYEtXMg503oZv6VMYCt+72vrfMaYi1fnFWXEAesJOuCPGIzDYF3h/OZ4vgQVljXyG9GiRZQFLU
 aOqoI8IFgRhwH0EPqbEdSPk6hDrYteq0Tn0fym3hvuxqWmcXaEPpI=
X-Received: by 2002:a05:6830:310d:b0:83f:f24d:fe19 with SMTP id
 46e09a7af769-863151bafcamr28935404a34.3.1795676017352; 
 Wed, 25 Nov 2026 22:53:37 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:36 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:53:04 -0700
Subject: [PATCH 15/19] spl: net: bound reads to the downloaded file
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-15-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When booting over Ethernet, SPL knows how many bytes it downloaded but
passes an unknown length to the image loader. A read past the end then
copies whatever follows the image in RAM instead of reporting a short
read.

Pass the file length to spl_load() and reject reads outside that range.
Use memmove() because the load destination can overlap the downloaded
image, and unmap the source after copying.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 common/spl/spl_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_net.c b/common/spl/spl_net.c
index 2be7b73ed35..1cdb7027ef2 100644
--- a/common/spl/spl_net.c
+++ b/common/spl/spl_net.c
@@ -19,9 +19,15 @@
 static ulong spl_net_load_read(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
 {
+	void *src;
+
 	debug("%s: sector %lx, count %lx, buf %lx\n",
 	      __func__, sector, count, (ulong)buf);
-	memcpy(buf, map_sysmem(image_load_addr + sector, count), count);
+	if (sector > net_boot_file_size || count > net_boot_file_size - sector)
+		return 0;
+	src = map_sysmem(image_load_addr + sector, count);
+	memmove(buf, src, count);
+	unmap_sysmem(src);
 	return count;
 }
 
@@ -48,7 +54,7 @@ static int spl_net_load_image(struct spl_image_info *spl_image,
 	}
 
 	spl_load_init(&load, spl_net_load_read, NULL, 1);
-	return spl_load(spl_image, bootdev, &load, 0, 0);
+	return spl_load(spl_image, bootdev, &load, net_boot_file_size, 0);
 }
 #endif
 

-- 
2.53.0

