Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B60C982C3
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2997380EC8;
	Wed, 16 Sep 2026 13:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S3qjHxCeeZUI; Wed, 16 Sep 2026 13:09:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6CB5B80EDB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564164;
	b=U+OUWrmf+viQnu6F/gIiHgtFUPXWcNAgok0nL2EyhRE/mUi2QQWpXOBF6CvZervar/+K
	 xdmMeuFzwoqpika9fpDIbAQniH9MHCBY7bO2Mbri2XKixqLrKwaYZQ7/ZqumbxdF33fn2
	 7SB+1mKnTGzIIC2XNoDqOD5g3LGoAgcqoLjosNAbNLwusejYiwOGfl+WbfYfeDqF7ly51
	 Qh51BDr8uxXmyLAmVARD2JjGgFuOuh5mfg/QfK0Ly2vnsHVdJwx9PuczJcnomWENMqKUB
	 GG7lk+gSMqUedpBt6qVk73zHJBIMvuToZa168vgfT/850gs9kr6jA6//kKR55nxfTcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564164;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
	b=UECSVI/j+uyfs695dB3A/gKrhX6ODBhm5ni1Ds+TMu8bTaOXEDpSL2+chCPAzAjp8TuQ
	 QaY42oDzXDHHIqjtHervpaXXW99RJnEZNy2pLvFDtE3ido2qwv6uxELZtICEBypDVzTZZ
	 IzEUyNAeXv7AuzQMLl9TJe3o9OIug0nbeNC5PqBEKV7zvFrlUulFNMv5Kj385i9WIJgxK
	 S82QHmENUJ05gKtcwRZpJW5CMNy++IN9dVO0+1B10u9odQP1UEaj/+LBYepDQaNw/P4VO
	 8uj4AWiJAMKYvWsaLDWrliL4gEJNfAeSKKTQY1VDewBP5tW6b/wzhLT7nlsU/scsSkg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="ae2A0No/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564164;
	bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u2PxeEfGtlSHUJuks8Bjs+uMYosBhwhc8o/502pB3LvS3MA5Bj1QRRE+rWff8h971
	 GzqsM8HFiKcGFQXE8fOzzDBBCzVnShRoND6x5nTWoS55v5nY+7bpDV9uj29K5Fez0x
	 UNJRKTLCK+ZuoG/sRasEbC1jtijlkyHnfdvKC9q7GqRhkEgbtIbin06FVNymhZ/qT+
	 UhK2mEoa7GEr51vsin3gnp1NU8Xd5QHnDVbG/0vpMtDCjYw/zHJuTugw/5QyXCEvSY
	 r7u6p0tFIxn+fzppDwqyNuUQ+oE2Aby4Rt6nMGEhBPpP+VYRNYuvNRYTNvgkMCF1Tm
	 FmZQqPe3kT89A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CB5B80EDB;
	Wed, 16 Sep 2026 13:09:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D9EE224D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CAF7080E46
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1l970uFfUxpk for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:41:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 05A3A80E3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562494;
 b=RTCuGMr6oNQBtivROrpykh3dAw9tcOrrlMr+w+karex4dyIU/xRERoqNH3JaDqiTWTHS
 pS0iE+S3ZfGfjKogapEveJ5vlIFR7wozH1nrmP5zlCIr+v6Ka4riq9rMToxB+IU25oYda
 YLVptFGa9fkJXncE0hL1V1OWeYKQ1cPWDlCkWS6486W+tboVArIEmybBH2l8R3n3mYGYi
 8R7YoMNOchqMi9MX2nhaS4Xzc0l+IM4mEd9nROLQDqyE0PcBr1HtI99WQoxfh6ZEbAKTe
 TRfdZxSBh3E1pz3noBPOmAVsKJLldhl4pJeHnk0X9QbODSs9XYC7bQMV4EHhnqLGpZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562494;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=RG3eTfo/rVJ/KzM3RM4VgpWC6XOUFmxlzJYe4M91DeenMRQahzr1TSCtNKMToF8X/Fl/
 Dtzjeq3kOc5obFhqGh+BkL5aFNq5KY3NIThwQSYx3lcV9N63mJs8V4mDK9bw8QRyzNhPX
 8i6Ie9Fxopv2ZIBXkjqaGL+TM6JyewcpeXtFHJVPT9y352e+fyoCCj9ahroLmGJRZOiZ9
 nxUXtV5Acb8Sbza4AYbHBYUG6eqGC+rPV/HZg4BtA8iKDbZ7ReI2UAzc4wMxx2wBfto47
 S02EqDLPENTmqRt/kvUwu6qS4qRT0ON0UF0qUnwrrogDz2xmbRJTEKArkpdgzhmt+WQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="ae2A0No/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ae2A0No/
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05A3A80E3F
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:33 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6a9fd7c1a15so94166a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562491; x=1790167291;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=ae2A0No/XttbFAMV48EuwWZW/ArSNDNzINHATqYLIwQh8Ozj0bX26lrUl2tUcmR/qL
 b6FQ0gBTBJ4RULasuVmHPQxHt8jIZpAbHB8bo4KgRa4y8Kin+cgYXkjpVyVbDfdGw0hu
 g3MjBwUZLOjlokgsA5Sa4sFWlyIEc6cc1BudTOqvcGYUkmcAYbNdqgYbAEt3pRDYvlaN
 IqyFFtejojDyvHa3MGH9FIPJjyDgWm+gLbhwkeZ8qfqykdmCzsHlHvcnLsI5QnQbrE1i
 FWbEcc2l0JBHhIs5/9nj8iA9IqRQAiHdC1exVZK4n+1HgyFzWkNmpUt8PFm0ArhhX6oM
 tAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562491; x=1790167291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=257aYOSOSidW2wxzwmdvs4fYeJ7F6MnP/T+Op0JMFxSMw+ShBimaZf2Z8LRLpwJNvY
 vMLl2SKB76UT85zW09xGwo8O2+rgBY0tWFib4GamMaNdxz90EA6aO5HBWvDxN+F4zwbF
 9/7CDJfwItkEPhcd+PXgrQcfE7k2gQ+Ia0801CxDRBb4Q7EN5JOVpMRjSTYEvWmYeThI
 tUdByiYJmFGcLqezsVJ0pkCgLnwRjzeNxhfdve2hQMpRuvr6C+8Nu8PPo2XMLmBZVlZL
 159MeamEncYloQ3ikaEqOX3n51R0Hw7bwoL23sZ9/uE6zVaMOdC/qgcB7LEXirXHfy0r
 1+hg==
X-Gm-Message-State: AFuF++lxv2QPma4f3eSu2QPEjsSgr2r0+TbwTIHqtwBNAdAXNm048lOf
 CGklFydGcjTDETHtBDPMDDrEqgvNaOqvAz5amOz2le7pR4SLeOHCHBHfXvmB4jYFvmQcXQNUdzQ
 +k/3Q
X-Gm-Gg: AYBFou3Bm14JQXU2P127XxCUiz6x3R+Z2et0zbQreI5DbYe59RcWxPd4inY/pzrAN5O
 OkxaqiMFMwjFsz7rpHi8jpKqBCFHa80D3pviEMqYrhaXheNH6dHpdazeLqUJhObOEfOLEdijNwu
 3+lys8Ys5/OpYQFuOt3fOHI5QrVXil8SrSJuEox4vWIMyFi6IswgikVMvR8/MHHdskGJcaRR8xC
 DQI8B0Pv/yjCbHar7TpQHj9OP/3/Um86fOuMI5e1mli/bz1F3VHsF3nhbK+RLapDre3VVnEx/Im
 w/kNyZ/wRrO92c2JqNGtAaMXpmrVojB92LAj1nG4CRqZlb6tKjbBpJTmIZj8m42x5er4Thklwsk
 taT7bmPCwx1BWZgLoGZVcCUnos1EI14DvrSwPTLVKadX2TmyEkBpmLbB+PMt1c1hqDSoQCjswpf
 6daL685tUN7sH32ocAgtQiLMYf6958M+fHDL65DNFVz5troiGuvtKd+phbFKfKj98LKdmqdLYZq
 oC1EMWWyQ+IX6FHhzu2IFU5aMmyypuQOEMnI+Fsh1KWmr77Fw0V/Cyn
X-Received: by 2002:a05:6402:354d:b0:6a8:18cd:81e6 with SMTP id
 4fb4d7f45d1cf-6aa2218a835mr1893099a12.0.1789562491530; 
 Wed, 16 Sep 2026 05:41:31 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2a1289sm1487519a12.27.2026.09.16.05.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:41:30 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 26/26] usb: cdns3: fix up after the resync
Date: Wed, 16 Sep 2026 14:38:26 +0200
Message-ID: <20260916123826.517181-27-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

Adapt the cdns3 gadget code to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/cdns3/ep0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index acff79ae1ca1..40282cbc3234 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -341,10 +341,10 @@ static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
 			return -EINVAL;
 
 		switch (tmode >> 8) {
-		case TEST_J:
-		case TEST_K:
-		case TEST_SE0_NAK:
-		case TEST_PACKET:
+		case USB_TEST_J:
+		case USB_TEST_K:
+		case USB_TEST_SE0_NAK:
+		case USB_TEST_PACKET:
 			cdns3_ep0_complete_setup(priv_dev, 0, 1);
 			/**
 			 *  Little delay to give the controller some time
-- 
2.53.0

