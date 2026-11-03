Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08A606FAEC
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SkVNiYgb;
	dkim=pass (1024-bit key, unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=rc7Fhp1X
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62A7760670;
	Tue,  3 Nov 2026 09:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7HVBaaBkDI2F; Tue,  3 Nov 2026 09:59:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ADBE4606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793699974;
	b=NtZT/6LymIpv6KFwjyKPAmlCfQtnNN3bfjLu5oXZ0E8FElrslhNoibelqfeZFN87mdnM
	 v7/Q1KmwiPgLKFqcdcXbtb7BmlgT/v/wfGanRd55LTHQ2kmUdd9M3ygbWFelkQdNbeuNv
	 oSWi1TdO/pigzgwjFRzDfo7d5EBts2XLCeGL/U2noNhq7tMd53AZ00Awulqj1RMoRWtHy
	 P6QKEQLsGzy2m+rlFZEJ9ykgYDSu78Bb9Zxi6mmsAcEIlubTxE3t2/7W8tlr26N6Pk2X7
	 USyKgpwBY7kSLl0Y47ksdjl+gt+21x+kw8mFqm7XfCrw2ncULKajw/5Xefl7eNz2jXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793699974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xnMrBvNy6nLtwpISCIV4VPNtjLra6/Vs/xJL2qWSgo4=;
	b=HlKcTxt4KFd5dX+q91fkmnUehLc49h/LdwwbvBhmG0fN++bCKtB1Z4xzc6lTE5mpfMmI
	 5u+Yr7IsO68+k4HPScqLxldZLqRkD5rZ3pAtXAuMM5UB1VpFNR+n44rVWbQkKyXB7PyOg
	 jizf9/74ynnfcx6LJexD75h1mTZuE48ROvUy3A35QfkxyTk51WFQzjZoyB48tUOWMLdcx
	 FlPuAfS0xOWIFSyn1/w5I+KY+HVpuaglgaAKfChjXCssXqgnMKUTdjFxsthwDKbh+zhvL
	 VJxxZi/HrNi0jDkPRgonttrAGcH3PqZQO8xWgofMjPFmi6+1h6jliM3hVFus91IOygQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=maquefel.me;
	dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=rc7Fhp1X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793699974;
	bh=xnMrBvNy6nLtwpISCIV4VPNtjLra6/Vs/xJL2qWSgo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SkVNiYgbLltZ7WesAvP8QS7UeW7cPO/J5Zy/xCz1xMzPFCFl/1dmF+yue2G3FTt3R
	 HjwUlOmUrdw8eB/v1TusWXJxwBgccVjajys8Ukxm0LEpNTwSfxoMaDPMFlfqDuL4Kh
	 b8T3HN04TZVpDkOYOychC7m7v9mHTlDRGSeIfGflsIxvdefaJNTWbMXCW3/5QSC0ho
	 Vavwzdi1MUOld9X+en4Iv/srVsyhC2EeDrTroIjpRyoRJ4SdAqL3SS5beANHPm+4Gj
	 dyuWFvjt8pURI0uFBVggH2dJW0df3Jjy6N48k53AwfDNPt7gIFrWE5betEsNZKTJRV
	 fbL/F7XN3TwwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADBE4606A0;
	Tue,  3 Nov 2026 09:59:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 592E52AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56B70606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cUnn_-6NP1uI for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 681A860670
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c32:0:1:45:d181:d205"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699972;
 b=H14Sxq34nfnXng8HF/f19qXajicy530UgnHwrSnQ69xgKLTELAqqwIkjf2DwY6QuI3qQ
 IoGmL/pyWzHk6aNlcxjIaD93YKdpqKMmcBUul4E6YtXYHorNlpaS1Y0NQRi8LUz5jbl2s
 IMhjEIYsMPrlobTQuQzUEYo7uN9LWE1z4aOSFPmk0FG+U7X0ehNfbPIXRcKBxHCY9PdZ+
 0odIdn5M6ytGuoSUCJjmQRg6CGTvF3u5k95pwbkYW+AYSX7w6bzA1ezCc+MhxW2jdV7+2
 u5+y7b5roRq0xff/s5wZ8XT8N3y3Au1QyHLafKOQSsfQTeyRpY6M2cGiVRPywEeJH9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699972;
 h=X-Greylist:Received-SPF:Received:Received:Received:X-Yandex-Fwd:
 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=xnMrBvNy6nLtwpISCIV4VPNtjLra6/Vs/xJL2qWSgo4=;
 b=PKPyNCnN5MQBle3waJx0N7srtsdMCJc83W8igC0g5Q0DmHVN4vOW/puvR8mCRqaRdkBY
 2TS9LqTuVSn0Uq3vVPyY3pHjBFx4sUcKQAgZ75MU0pmns3VuGCJ0TXh8lRlkr8Z5/5Rlv
 4PdwCcCF9XsIkQUAlZtNkSQpfISUvHGXfggGIVeTmn7nHuzBrQ9LQUVHOSJnVYJd7bd1T
 1tPDlLSErE+yfW3hKX+y1RlSDZgnMmI0szzakZJukKZqvJQP2UNck53ytjeYY6Nh6NCmF
 +BUCxOi+ntm2DpxsNNm475i9Ol8NVZQMws5j6yG863dQO1FCXjJfrBMNgehegarXWjw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=maquefel.me;
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=rc7Fhp1X; 
 arc=none smtp.remote-ip="2a02:6b8:c32:0:1:45:d181:d205"
X-Greylist: delayed 353 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 03 Nov 2026 09:59:32 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=rc7Fhp1X
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c32:0:1:45:d181:d205; helo=forward205e.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Received: from forward205e.mail.yandex.net (forward205e.mail.yandex.net
 [IPv6:2a02:6b8:c32:0:1:45:d181:d205])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 681A860670
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:31 +0000 (UTC)
Received: from forward104e.mail.yandex.net (forward104e.mail.yandex.net
 [IPv6:2a02:6b8:c32:0:1:45:d181:d104])
 by forward205e.mail.yandex.net (postfix) with ESMTPS id AC0D895260
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 12:53:39 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-70
 (mail-nwsmtp-smtp-production-main-70.yp-c.yandex.net)
 by forward104e.mail.yandex.net (postfix) with ESMTPS id 8A5DEC003F;
 Tue, 03 Nov 2026 12:53:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70 with ESMTPSA id
 OrH94I7pRiE0-YVuu9F5H; Tue, 03 Nov 2026 12:53:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1793699608; bh=xnMrBvNy6nLtwpISCIV4VPNtjLra6/Vs/xJL2qWSgo4=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=rc7Fhp1XMqmw+fet6hj2mWMd83jeSUdhjqgMX2eGSdYOrOsfTlDDHLPJTFs1llagt
 H2jYcdsp4g152Atq3ErRmjB3HfLln9eD2S571hlv7p80aY4kFU7t3QfEFQkJ1dhusc
 +5UVYPzpEO7EdQUSghLOPesEwQ1VwsKM3bAFa81I=
Authentication-Results: mail-nwsmtp-smtp-production-main-70;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Tue, 03 Nov 2026 12:53:00 +0300
Subject: [PATCH v3 1/6] image: fit: allow IH_OS_OPENSBI in fit_image_load()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-riscv-full-fit-support-v3-1-e1dcdc9638e5@maquefel.me>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
In-Reply-To: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793699606; l=991;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=oer0XGBCn4nsRCSUDRftqMD/bXHuxdlin5xIgN86Cqc=;
 b=05iOgefb7TUxi+oYZ/cLzlBZUGOIjbnJuOSMwWx4Xngz+hZN7G2CIBff+uJr3Xg2wpYNqdXyT
 N4Lk7l+9uHxAT2axKq38yGMFij7/fVO/xeCv20sd0AdRHsfTqkFc+go
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add IH_OS_OPENSBI to the list of supported OS types in the os_ok check
so that FIT images containing an OpenSBI firmware can be loaded without
error. Otherwise loading OpenSBI in full FIT Image is not possible.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 boot/image-fit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 3ec016e70d5..4e39279b94b 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2394,6 +2394,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		fit_image_check_os(fit, noffset, IH_OS_U_BOOT) ||
 		fit_image_check_os(fit, noffset, IH_OS_TEE) ||
 		fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
+		fit_image_check_os(fit, noffset, IH_OS_OPENSBI) ||
 		fit_image_check_os(fit, noffset, IH_OS_EFI) ||
 		fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
 		fit_image_check_os(fit, noffset, IH_OS_ELF);

-- 
2.55.0

