Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C07C61DD3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 06:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E4C66078B;
	Fri,  4 Sep 2026 06:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GUI7DILyoOvw; Fri,  4 Sep 2026 06:19:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5832D607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788502764;
	b=itsAplqUHySHDwC5fPdnyJNvrI9FFj4s/DLdry2YNKlvdzs+8zb72B6jaetb6tLDkRj9
	 dRVmQz+khTaKvbs4Mt52mOt9ssBcVG4Yo7J1eMzW9zARoyzWzDeLuiIJpjaEA0Iz0hP/k
	 6FK8LQ/M1JtQwTqdP9rHOtwBhwl0gD2iGxYLvIZ58iWGUqaTosgXl/9dRYHd0nsrzjqLe
	 w8QkotoK1NLE3agZXd7oRiwPHyKsO02KgZ8JT6Yzj+rlrQ/GqS232sAIruBoLS8wmXQTy
	 YwLN+yB0VkZ5WIZ1UmBITLslqamRI2S7RXLXc9cyJr7egAN4fnhca7InElGEkEVFYSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788502764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/4gEMpdM6ZUR8/Vq3x3t6fjtaueN1HUK1N6bJuxRxrk=;
	b=i1TRigvEuuYngbZyEp9ZGmaqNoLXWaPbxaS0ScyPiybqCX7l75kpVLt0lEaUeUr2Evea
	 iPQyCnueq9ywLGdWrchddZKaz9PNpqQkAQ7TkKeksJG2rYWyZQJRFhZx9rCnag+o3P0+u
	 rkLjUlTXLrhLF5uXWgyiWN5ZdPyF37aVe9M4Eum6/YQxR6OFNNv6EVXkAVaExL7/IFNpM
	 DxyXkONRPjS03tRoGS3YUR4yXnWKq/wTrC5WfcRwqjMh1wUpBc/0m3ItJgwIQziQwEAxq
	 +Xu1EvqXEfcXTLth50nbGz34ZNHw17/nVEniv/8FvusA01odqMsrcby1Csv4NaQhnfQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788502764;
	bh=/4gEMpdM6ZUR8/Vq3x3t6fjtaueN1HUK1N6bJuxRxrk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F/0Qswkm2w2dY7G7rnVbXSkO6fMujT2l20maBR4OMBboO3pkt5+gYpCJcjB2oavBd
	 AWed+ZKyR3MaapSuQPAIfT7vJQNwfUprQcGpLx3DqBTBGL40YNZwd38/zq8Lw8aoAE
	 UsajJKGMq5HEdxnJt9wwMX6sSO0T/jUu6CsqUwYh8F6rjHYOcnsBqSkar6T0sILMPJ
	 mQCpHy6/98aynzCWpP277qxLZ1RzGCaQmRS0hz4YfJpoMe+m2AazgFpTjs65RWqk/g
	 gMDb2STkHoh7DmUIka31+ztBPb4DMis1PG3tWKycgt5Qu4iidc3E2xNvOT+uG/TLDc
	 fRnHj7RF5Sb/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5832D607FF;
	Fri,  4 Sep 2026 06:19:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CECA9B2C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C00B680F7C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UYNjl4Bai1Z3 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 06:19:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EB76380F71
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.150
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788502762;
 b=BupBxLPj2XmdIlC67/SC2c+XdfX60HpJskL7yJBD81qp/ewpL5Ja/XJZTd/SmkttFRoL
 DkrceZIKcf3UVDxDi2cTstKT8r07rxT4fabKDJ+T+gpPCT68IAMJ0Ew2cejmKPB06ndZs
 O6m1L68RZiO6Wcvyns49vcHJySU8nq88mtjD2xwBn5lrSct7K/ZEepQaydPJ+6inH6c+7
 IbrfNexnX8KdtpCYMJZo/nYBYAtOWcijJXzizpZ83aP19epJIv40iHD8waa73EiIeJ5uk
 h73SIaBgd2gpYeqyM7iOy00udh4hH6ezk5U1mAT8KS+jjjnRboCg7zFqKQb2QuwuzYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788502762;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=/4gEMpdM6ZUR8/Vq3x3t6fjtaueN1HUK1N6bJuxRxrk=;
 b=SpLIvcIxvoeiSa89oSVX8atay+Hksmg4K9LoHgiaOCYI9VMr9CSyFouMUg2GzQEOyDrv
 J84wsMq3KhRRa6T6K1OxGPkqoE5fKiVbFF4t52qFTMkNSRt0NKDAled3/POaiGUnS436h
 vWWdGhc9HTsiV+Z+dHYHRskH+yCYVe7Wff+DJe0BRQc1JkrPPnZVZ+5Q4OukzIkZQKOZl
 L2GXR0eE5zNCp66DSuG2ExoH1ropObN+n+L7INMwqNXOqb0w/0FpThCpQRAcSZK9scIB4
 3IjcGnVQjllYxn6Hrqoix5F565vYZ5Sj91FoK3sNhoBroM7jp33cecanA5mq0hnIcxw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=sdWLd4yo; 
 arc=none smtp.remote-ip=178.154.239.150
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.150;
 helo=forward103b.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=sdWLd4yo
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net
 [178.154.239.150])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB76380F71
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:19:21 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1791:0:640:6f9:0])
 by forward103b.mail.yandex.net (postfix) with ESMTPS id 8F245C0063;
 Fri, 04 Sep 2026 09:19:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id 6JC8mRggAiE0-CFdawfNG; 
 Fri, 04 Sep 2026 09:19:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788502756; bh=/4gEMpdM6ZUR8/Vq3x3t6fjtaueN1HUK1N6bJuxRxrk=;
 h=Cc:Message-Id:To:From:Date:Subject;
 b=sdWLd4yoOnAeUswHbLnsBv0eXlIg0SZOSwDwL9R7ZeppipjyvOXdPCE7tMfdjBXgo
 khsaLLxUWYC0diTtzNTkIjHIZ6FQve6UIy8DO08SnCPm5RHrdWWtLdblaPdLafxcUH
 YEnxg+WIGTtFOvmDMt0sETv1UOQZBPzcqpNjSLgM=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 04 Sep 2026 09:19:05 +0300
Subject: [PATCH] arch/riscv: Allow booting from NET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-riscv_add_net_boot_option-v1-1-125c3edbdb1a@maquefel.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBMsor+rREg6Y81GRSWC8O5Jy
 7f43guJIlOCtXkh0s2JvavRtQ2Y63AnCcba0Mt+lIscRORkbnUgKkdZae+z8iFXJeyENGtptMU
 Jqg+RLD//e9tL+QB4NKMXawAAAA==
X-Change-ID: 20260904-riscv_add_net_boot_option-f7de8b0cbfd7
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788502747; l=663;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=iDtaa6NpHaBmFDS/zr9f9PZqoPgS8Ib2Ufzu6icnJuo=;
 b=Ru1W7lHFdPHbg8X3zWsjkvzvUmWX7LPwKvqsl9cS5dIrs5AvjkVb1jPyPiAomAdvBsnG56BEa
 hJVbjHDXSK/Bz9IGerAhGf/g1FJORQC4KChrYr9bkuHwbOWqoWYlhQW
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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

Add RISC-V spl missing NET boot option.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/riscv/include/asm/spl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/spl.h b/arch/riscv/include/asm/spl.h
index 9c0bf9755c9..55cb56a3246 100644
--- a/arch/riscv/include/asm/spl.h
+++ b/arch/riscv/include/asm/spl.h
@@ -27,6 +27,7 @@ enum {
 	BOOT_DEVICE_XIP,
 	BOOT_DEVICE_BOOTROM,
 	BOOT_DEVICE_SMH,
+	BOOT_DEVICE_CPGMAC,
 	BOOT_DEVICE_NONE
 };
 

---
base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
change-id: 20260904-riscv_add_net_boot_option-f7de8b0cbfd7

Best regards,
-- 
Nikita Shubin

