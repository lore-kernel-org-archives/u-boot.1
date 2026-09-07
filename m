Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D233DC79F8C
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 01:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C43D4057E;
	Mon,  7 Sep 2026 01:15:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UEubQUcPBfDj; Mon,  7 Sep 2026 01:15:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9AD8040575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788743749;
	b=IEUKLP4DT3n2WgkG/64rKhRTOaz8YNZjiSZCAYSssleiwZgMBJ3PlCxLEHrQ9EGoVh1X
	 bHBmRgOXHIK5jCUAHQ5JkcX19aL4AhKt8kO8URPrCO3Zf68rn6yTOqsDRvVHpnd31PhFa
	 N4oYB6vlMOhAZbehpWNlLmYn2xiWvfu8HfKkqiLq68E186gfdbr9zaobOttTTie2S/Z50
	 nwxRLrIlfmRJ0uC2AfjutK+CrsiJZBApa0Cf3YbFUOpI/44vtARF4o9/LGA2oh8IK4RfL
	 wrpkpnasxYRVMjB39SsTwF405ieT/s7ORwyYGetdvOjc9bd1NegReMWuhqvJvff6sfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788743749;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JoaMLtPP+Ohk4fOR2GgME0Jxv9//qL9qlGDKzdLwhvg=;
	b=qH6ltJDQej97xC/bPsjcBJxH27XCAPw+TTzCNnhLkcCkH7IO4AIwhKuXQhsuWFD/zCon
	 Tv+n+l/Nn3UNX4thLlXtgouELrqjCNd2E0eGIpLht1lC8aWkzT99P1+VBBEUArhEhAWkN
	 GsRN93vhPwbq+foP6hC7f4kM+py6Wtb0a33VZavGY5UCo4ASsB3aBMgDTtW48BnWyX0g9
	 RQXWi3jZMPS/oQ3T31rkqNcMSZ93cbUhDYSuFhlUKDOArDYrG+Dsr6qiDOfyMepqgIprX
	 fsAtOTPSt/4hXyggjpsvr1jgMwORE8h86QwWtRiudeOTFQvTJoeovhaldxt74K1ZQwA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788743749;
	bh=JoaMLtPP+Ohk4fOR2GgME0Jxv9//qL9qlGDKzdLwhvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z8DhSHBBrKZ7BJRJB7goC8QnRoq+cTqgMhb/gnNOoM5Dj4ayBthZk3hB49R9V8dvx
	 sO0/WVKwYKA7bhruAmOCb5XO9QA3s56e16UpX9SbbQ5YvZiInCd2a+3/1NQEUzkaks
	 lUF3wm2ylPpn0s9ji+fIfBlnXHiayvTA23wWFmk87XVTfWruLybvxSypFLm8ymKt+C
	 NlQAKpS2lBGvUMqOJZHW19jGA+L6ifJUc079RmumLA3xtZjJwDumaq6eSiILkxtyRJ
	 LXToeUOIB+uXIqBB8ulV5IZhVTAX91Q9E1JWkO5Ta3DXZ7joP2mShUBJ6l6JC/cm6P
	 dSJPPj3jOa6AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AD8040575;
	Mon,  7 Sep 2026 01:15:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE9512FC
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 01:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C48A4400AF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 01:15:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wEZ6H2HM5kJr for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 01:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 44E2040068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788743746;
 b=srpDIswP8XrfsyeFbFJxCU2wxNR4tuHugI7bO2iIDQjMBM+Flp3baqf3nwEM7TfDPZSV
 UENfaynQKfI4bFt9ltXhdf6FZs9B++iBHSfNCAEc1PMQSeSriDy1qA0gLvYqc5V/m/8+O
 4uDp++ompde3Y05/w66mn4GVEWUu6zuOFlmtpMR2BYNKIXztTvXphtrtHlqSCWS+gO6bU
 1sQMeeRQA3tSwlrxTtykihymHLXfBGrt8oqBVErWJrADsQ2QexSVT2/dVyofJkF4Q47op
 UKdszeiIeWN44v340aJoWu/OouKitHb/C3kUdv3K6QW8OKW+RQ762j+aVAtaC/ZU/KQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788743746;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=JoaMLtPP+Ohk4fOR2GgME0Jxv9//qL9qlGDKzdLwhvg=;
 b=LGr9cS6y9y631SaOAB1wWnBABh45K3SFzfTxoHNH2BT6bz3k2/ORRyhLhYlcl5wWKlYG
 5lIkFz8GFl5nrR6qMVaa9UxK4YiXgyXhVT5rob+WpreenTaBw7/FG1EP2VQEQgrnQzCDz
 UJEEMt6Hj+iOYA7y+jgwZBz8iuualMvDB0Uhlc2vTW7mayZfXmlBzfxq1SYcfhSE24Jpz
 uFwdAEpd/gZbbzGlyeDu7VSXE9Tfur3nbRIZgfYkzBs/B10FfBmYYMaVanPs1AYX4HIJG
 kiEdsn5ZzQ6oOQig9yE93vRSpWZrfhqrFo0OIMgazPdSXlJlVe4DdmjoEfSgcJy1Kpg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZRXZxcoo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::12f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZRXZxcoo
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44E2040068
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 01:15:45 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5b5e907853eso3017493e87.2
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 18:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788743744; cv=none;
 d=google.com; s=arc-20260327;
 b=aHX7xXxDqKfBdszcJFg0Qgj81n3np2RGxiBkj0XbArh7Gs9MlV9Wxhtn9k+Hz3dBX9
 gcLnPmSoDD/HanvNC4HaaMsZJ631S+gUJ7fMcluOjtrThcuMAA1YYB3jXLpGxf21XMZb
 P4Jr0Xi2rHIZ8UJk1fXxg1/7AF6NTHwAi4W+Ob8i0WxB5EILJEiKtXmbTzej1OX8U4dA
 j8nmHxw9/WIIXLP6Kn08OywrDcfQdsP6Kr8vdWLSOrze44PgLeHxNimEHtcpEajxfYcV
 GnsZnIDTsjoCgQH/1QKnph9f1L+mmmPkiaAanVqIWhHcYoBy5w560NrkUYTQ2iIz/I6x
 Sm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JoaMLtPP+Ohk4fOR2GgME0Jxv9//qL9qlGDKzdLwhvg=;
 fh=W7nFJdC0VimQDyQTOI+Ok8t3SuBoM7tOrPlNV5bPswY=;
 b=f9NZ2fSbjbipSPWNBJ21fbm3h6PpdfX9D26WCqLd7N+nwNeT2f9pTATuVXDkzJb0dn
 x51U1QDiKgnoynPRSeajnQxY9OwRNObvlojOlVCAvlf7gXQJMXa20EqLYqgxGH76NDg0
 RTA7MbpkgtI6TLymCKekMWHuvFT+sM1LkvjmzZN6PhHzwar3pIkbixQhNc7z+kQK/d4Z
 54HpB8A/0Lt/TSZ1/4GygduCuV+dEI1nQ0y1hzSSfN6AhWy2lCJzPQgIZAQK3Jx64fGQ
 j6PdRJOdQXb0LLhQTQAK0iQ9k3bvx9IPhUqSuS5fcReaTTU/Dp16zt+78H3fd3kbJR5m
 WjsA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788743744; x=1789348544;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JoaMLtPP+Ohk4fOR2GgME0Jxv9//qL9qlGDKzdLwhvg=;
 b=ZRXZxcoo9pZR0f8Z8IGW1qI8bcVmiNwqXSQ8pHr6mlOSWec4+Tmsdu4S1e5rnELJuT
 jD0b6hn3mDwVCezC7unUx8ChrUu5rX44575shVVHglNXqcxeHvgTDbVmfCmUbTzHSOHG
 E2h1ITIPROR3zaVIL0paUD+XeP0JlSxiYo5zU32Lkcgs6p3ulEDqrYlBi/IyByu0x0eN
 ndD4pXp758pElS8GT8NYa1y2GL2eEOrdAF2gi4nvYZ1hj4B+XXQoxl57F015RjqLHJaZ
 u6gWnCIhT/y217q/TRB7R/AUgdT+LBrV+iLJV6Y26fr84LiWQe2mt+9s8dNzjRsbqXlW
 ozlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788743744; x=1789348544;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JoaMLtPP+Ohk4fOR2GgME0Jxv9//qL9qlGDKzdLwhvg=;
 b=GRXppMRbGafHhtDj++51MUlBCgZMil7ajFrHFCgZWDmYNbXXBfWQKUxzG5HquCKb9N
 vk6cuXr8NyCdNZQV6o5TtEf5fxuVsubinvqQWj03CTOSL54xpi9S5wS1D1/Ojt5ew/KY
 5XQIhvmQkKGhWuc1ASPBt0VKOD19NysiFK2EUUenly/ciq4yEaMRpjGmPyaDj62fxmlc
 PE1YFuZKNFIvILNJdlz7YXFb3K0mBLnIEedBxbQHIkJeCgWi0xHbi6j1I9fOjc9CALAJ
 ZfXhewG0/FLnQAqvs7kdfP1KavbILLD5aVFHXeE88Xu2dRwEq9b0TwIv62TDlFGmVLjh
 CD+g==
X-Gm-Message-State: AFuF++mVbyeK3+CRwxkaWQO8DZ5zX91npCzZSPGC4AXHlGaXP8B4iU78
 iiEZ4gp8sLJyRUtT5hegBZie75gPpU8xDaq2Z7wTz5okwdhvg+2APdkfBeWeSEEZhNRA3PqrN0k
 4/XgOCQPugliUzGPLnvv0eDRmIdqkU3w=
X-Gm-Gg: AYBFou22tKzoPhZSO1r7I33OYIqGzvwfCTWVU8PJFqyjNYLXXXl+MQHq8M/bYTHiJGl
 ELnlK4ThPtczBdQjflAlkrRl8AtSTAHd8mYKvYk/g14uZ1sS6H3tAuH8U1h+jJJ/6ftmkRqchdP
 1/5RwRVcMHe2OLlTls42RE9Ha8hGx6qbU5X6TA2NdspUA8EsZUIuMVMo4lW+K2eA1fh0lV/aq8a
 QgaCwbQ5yJvVqpgHD9TY7D9z7csWzoN57Btc57F+79cqmvhKOOZHfThH+JuxoCjLrAc61zK0YsC
 HW2YEUZ5vrzqh8wdHqVLcsCVFYnWX4nsOu6MoDhasxZDf2g2Dc50F+7xU+/PiuLlpkezsL8vwZ/
 tHlI+yZ5UWJ5f0/f6NWrIInVmjCF71hch6g==
X-Received: by 2002:ac2:51d3:0:b0:5b2:a353:e4bb with SMTP id
 2adb3069b0e04-5b616edeb91mr2992241e87.3.1788743743328; Sun, 06 Sep 2026
 18:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260831-imx95-v1-0-a5e482080196@nxp.com>
In-Reply-To: <20260831-imx95-v1-0-a5e482080196@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 6 Sep 2026 22:15:32 -0300
X-Gm-Features: AcwNN1WOF2Aa0TNC7I7kYEQsM-PmFL_dwAjuU9gsXHATUNRs6gmCaQtsATN-Ojk
Message-ID: <CAOMZO5DNSDAH9L8_CFoJA2KO6njUOwZ+UdsFXOKX6f1xDu62wQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] net: fsl_enetc: Add SGMII 1G for i.MX95
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Alice,

On Mon, Aug 31, 2026 at 4:42=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:

> Changes in v5:
> - Convert XPCS PHY polling loops to read_poll_timeout()
> - Clear only 10/100BASE-T bits for i.MX95 SGMII 1G

This series breaks CI:

+drivers/net/fsl_enetc_xpcs_phy.c: In function
'imx95_xpcs_phy_mplla_configuration_sgmii':
+drivers/net/fsl_enetc_xpcs_phy.c:969:15: error: unused variable
'begin' [-Werror=3Dunused-variable]
+  969 |         ulong begin;
+      |               ^~~~~
+cc1: all warnings being treated as errors
+make[3]: *** [scripts/Makefile.build:272: drivers/net/fsl_enetc.o] Error 1
+make[2]: *** [scripts/Makefile.build:497: drivers/net] Error 2
+make[1]: *** [Makefile:2228: drivers] Error 2
+make: *** [Makefile:189: __sub-make] Error 2

I fixed it and applied it.

Please pay more attention next time.
