Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F2FCA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7C2A80C06;
	Mon, 12 Oct 2026 22:28:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FefM2qu9xc5Q; Mon, 12 Oct 2026 22:28:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E9AF80BF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844091;
	b=B+YTCTB27p/pZwY/y3P9RBseBJpud32cnwMea2PeTBSn/xKLa0THt+P6JExHR3o8Zi3D
	 d2/l64r0EF1TDOP/csfCBvIfi3zyl3fxFirLUCVtD3QPdHQcooqf8julYwZVJwssktJOm
	 uQb1jup1ex2Llex69hfwzamDV6e71CxwlDy3rR8wsIdzR9TRi3uLHIlOqim4gGv4uXyQ9
	 xTpTJdqKxKdcUA+dEKz/bnDRcvjot9mlV6Dg79mCCKM9UaTPFPWYsWugyXmhJ0Q3Z55PX
	 +3gxaJjgtMUDe2AGnm+uDKGjH5a4L+CgF5AhR4Z6grbfa8otOGXyr8p1/3EIQj+secA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8waAFYxKiAOIlYIuqAEUCMvcjpJE0AZ7HJqWnwubYsk=;
	b=gFo1s3J+IEPNeR8wAcLILNUu2gMcVW8XgSwWKa3x1gDLlhqyBW5ks9yxXw8bI+fo2sjk
	 k3O+KaYkdIQ1MGehE30yhG1OzbYBq1FovCpO4EljpcKX8N4vwNzO/oe8Z5qcFTcU8hx89
	 lbipaxRPXD+Qt2uxOcxBd1UtJtwazAhH1WDJ88zd4dZxJ6u6/HhHVZTIVQDvXtSHUOz8Z
	 in1yzYOEQ2jELS7EhyMqM+Tu6voPSYx1jw/xc9lntyXhGbLS593VZX41H3XrH3OR6ItKa
	 pQjbQJdBjkwnGim04aeFAEzYgccfxK4sT7zRqkpw9WNUtdDHs203wRC+MNPR3uuOy1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844091;
	bh=8waAFYxKiAOIlYIuqAEUCMvcjpJE0AZ7HJqWnwubYsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KKg6OhZ95eZLCgG9WEwyjQXNQbW1FfLnp5LXTqRCCdy/gEFOgSnBaA29qwiiIEpvq
	 OhC1MvhYjwA5SFRe+JpinJtOf0BGL5O+FtzfFqRmrT8R1WJ9zV8mRKqzsAPfztUuz6
	 /P0+gYLCulO6NtZ2d4fo4lH06mPqORBkYwaLWBVuMNEZVHfF6/u9YMR8aG8YPM4zzt
	 xXQm53af3REmoBwKjCHIGZ/VjBKRSL6nifBxaigDWtVfFrActSHTwzRy+hD5kVIfbh
	 QiXE88nEHeueZCxYzo/SqulGUOvRaWugUfUNgMA3c5eFACj4Au/5/Nc6wAc0K2AgM1
	 to29f0QP0UHRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E9AF80BF5;
	Mon, 12 Oct 2026 22:28:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FD784DD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35C96606F8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ayvJv16shBsD for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:28:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A98D605D9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844085;
 b=VD/Cmn7Z6Qqq+9NQwEDdg6V3veM0yaH9/Mza3O9mly4U9TUP7lmfbCVROnNbNrBnuYUd
 CZveiu/y0xIjIAeeIOz1yezyKb2JbI7ubzYfNiRqBbz2+c88t2hEyXJxK1DHRbE2McIDi
 oXyn2t9609gIOmnzDmhpTpiM9XTwRZ6gK/N51ppgjxctUi5hlLYIe9I04CAPTFct3DvDO
 a9s/YQZG/GZxt0EF7PK7LSj2BRDgwnqRsQT6PmRuxVh/iVxkMHeBJ22dAPQOIrMTL1KAr
 n0Dy8OMkPfEXxVjwY2zpor9lerxhiKP9+6NhdCfipsxMxi36tvL7E8C+1Zy1Yjgx6lg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844085;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=8waAFYxKiAOIlYIuqAEUCMvcjpJE0AZ7HJqWnwubYsk=;
 b=jBBEfGv4+SMbpLuAPBBz/UDK091yp4c+xMLHedlx4zyqoaSMO2ItGOUVXQ05TprG9NcF
 8Cc/Teri+EC++SGzIDxth6cyaTs2YUiyXy5rTgU16aUevbS0bssZL4Z/R5Gjw/cOzKA93
 bRHr9QZK33VZO8teijvrVdVxDK9YTe0tbUdx20QXvEIfAEXpjHazmE4Y3td+xFmuizHl5
 8usdR+MPESHMVtvMCBavQS1V5N2b84AAc4EGZ1f1UqbaPX2/HgXoCuLXz0E624o+K4WQg
 vflXwHOGMB0GVj1jirYT2HuyN4XszCAOTfZznCypa84ybjWVqvOmqi692+0BHm1hKNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="H2pAT/Yy"; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=H2pAT/Yy
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A98D605D9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:05 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-475920b9ca2so541835fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844084; x=1792448884;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8waAFYxKiAOIlYIuqAEUCMvcjpJE0AZ7HJqWnwubYsk=;
 b=H2pAT/Yy0GpqXp/l8GSnBIX20k+gbJI1SOJy6BQYcCUVMqAw8JiLUNP4Dy0b+2T9Ff
 k29aGxed/+sC2XhsdCwh9IxUfZ90VOR2QJiwFQGtOAI2AXq4WLUrk1AfCL3Keh8XwAxT
 wWdlIOqCyw6xvn7pn7BcDvgpswrR/DZVur1G1HZYSFpnyOPVD2c9vMsgx6HUdPIu5RJB
 U7DtRLbnd4RZAGxO9IFN7ldpP10gBr4TxbrOAkSf0zLaKKVPjo7eqknV1cM2VH5thbCd
 JtNy6PeE9hzrI7F+GMY/IEAWjNSdfbJ+Vo3NFr7X6ZyEQ3MeNvgEQI1mXrmxNECEeJS5
 Hdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844084; x=1792448884;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8waAFYxKiAOIlYIuqAEUCMvcjpJE0AZ7HJqWnwubYsk=;
 b=MKUe7/zYsISdC8ppHzxJhZPb8LsQrsS5WwtrajMK9ZFre2BUIbKUl75qbzpJu+s1J4
 k9hiG6bJe5KVcq1kzTaiIP+RhNfofE6VzJHDfMn+agxSOeq4hStjGyHtX4OD15y0cCPR
 dmtaI3/HSvT++GWN2rG+wGo3WWEGzDnWNv5NeAjDZuJLpeC5A43+i7oSCuJie3iWLQ/6
 ZzOgciUekKgliXBJGpCGf5vErr1M9juJzgRrtKg/qdsUMt6Y+8S33o6iw+ey6pimle3+
 hmfWaJ56E4ZlOB6sIJimJCkGIf3K0ZlDXRZPnkidpQpyZ+e9ruoSdYCv+wQ0/Sq90foI
 wdWQ==
X-Gm-Message-State: AFq9FYKOnKqv2qIU3ADjhx5dsCbUQStAX8ncN/iNqXq0gdYiKmYPUlMe
 AsRC5ZMSwOZPV3ya/gDblNCJFfWLV/NVt7/8UZQXAOhlYsgJFVIpA4RM
X-Gm-Gg: AYBFou3ZKCbuLIiNpn5mxWhcgSr83yZAJmFaTMUfkDcJPYhB7JJS+6oUTjHZqTwcID1
 bvcYeKMbXaqHJzSkAQ/dIMVx6EpHeNH9Ktbxc3047DZrCAcOUqPWCQltjExnOx0FVJ6yAlIXPSn
 7e6s/jyWwxkszK/ci+pZwun37oAexXtmEYfYk0vVwnaOewhEImyvhKDkaMfoFixATbVxZxsYenJ
 FJi8Fz21Nue0kNOn4mczW7DyHxg/o9rk0wVHhJ84mm6ATr559u0+8uf6iRkGLNeQ5y+pX0umVqq
 xX+aQTosPGdQjj2FpJZhO7Ad/spQg0XRPKVNjsSgd/E4hAEKBQD186+ud65IP6xVpVy99DiaoQr
 vICvsAkR6eQWU9Sr1pIxtrWvrkFEnpDUOdt6ku6reltOspkYW4OODgqZmVqyM5cO5QFNP92wbOg
 /XMndmnkGT9DHrS4Y3gcNtFMjpH9nOfRXays7/tPPFvdKIjzhkCFuRSP1tkijUw3Lw92EJguUqF
 cdfaO97FAapPBGZ7/09gxDpld3pbUFN889/RhVBwECrfrX2puQ7iLSx3TRlbgs6sTur/pgly/5E
 M/IMqVs/atEDx7qYmPVxAjDSXXw/y7NiNk0N7uk20d03NKj+EW0jBD8Tl9bT3mafLpiyKQd1Fit
 ZEB6uvj0+uAYFJkAosKsbEg==
X-Received: by 2002:a05:687c:230d:20b0:4a4:5e27:70ef with SMTP id
 586e51a60fabf-4a45e27b906mr3367188fac.32.1791844084129; 
 Mon, 12 Oct 2026 15:28:04 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8582a95sm10402859fac.11.2026.10.12.15.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:28:03 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 16:27:59 -0600
Subject: [PATCH v2 4/8] net: mcffec: return -EAGAIN for empty receives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-submit-cpsw-rx-eagain-v1-v2-4-c6a20425c15d@gmail.com>
References: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
In-Reply-To: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

mcffec_recv() returns its initial value of -1 when the receive ring is
empty at poll entry. net_lwip_rx() only treats -EAGAIN as a non-fatal
empty receive, so DHCP can abort on an idle poll now that it checks
net_lwip_poll().

Initialize the return value to -EAGAIN instead. Leave received-frame
processing, descriptor rearming and ring-index updates unchanged.

Fixes: 53a0ca3757fe ("net: lwip: finish DHCP before starting autoload")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/mcffec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mcffec.c b/drivers/net/mcffec.c
index 7e53492733e..b2b2a43c3de 100644
--- a/drivers/net/mcffec.c
+++ b/drivers/net/mcffec.c
@@ -430,7 +430,7 @@ static int mcffec_recv(struct udevice *dev, int flags, uchar **packetp)
 {
 	struct fec_info_s *info = dev_get_priv(dev);
 	volatile fec_t *fecp = (fec_t *)info->iobase;
-	int length = -1;
+	int length = -EAGAIN;
 
 	for (;;) {
 #ifdef CONFIG_SYS_UNIFY_CACHE

-- 
2.53.0

