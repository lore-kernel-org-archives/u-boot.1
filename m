Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB49BC982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 02:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D903780DDA;
	Tue, 22 Sep 2026 02:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tNmCPxQQ_ZXF; Tue, 22 Sep 2026 02:02:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0FA4C80DCC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790042527;
	b=m7Uh1prNWb1Yr+96TdnOoyGMIEbziFAUZZilDR0T5Z+iy19k9i8OIFEQfBbwdaRzWXlB
	 B87AD0iZ2JTvHfFPS8lwMxZHY6iK0BwO2057RycYxr9ZTRrWdC0///zNLyYLOF9Mp6aNJ
	 ED04nqY4PPGKouyiXB93Cn6cW59QKHBayU9ruda4sLNEjsIK9LQjTvIq7o1eMrYPJdBX8
	 cOPB8JWzyAt7DgwhSogSOyHGbLnnr1NjswFZsQa6D9hvYOTB9nwvxItoyRvDggEYxMtL4
	 F5Z7CJhNhMTGoMrdthYLinMsUqcfMhhUwWP1CFcQkmmDCIn/UhpLnsyhfKoxND8OxPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790042527;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CCgVdZT4+kNKzAIY//UwujioMlQ41ec/eQyAshwKgTA=;
	b=QLDg5WRp4PwV9EM36SenE/cVDL+KO2jNx07a6OKQErW2eg8p7+xOKC3jM4NBCQmtepMI
	 OTMSJKNyPbP8s4ZzSprBPjya6fxNwG+dd834GOTMa/RiF6yBR73+emUwUKIa3Jq75oRBx
	 6p+asjLJ4QRVAG7XptndBZszfNkBaW0lLn7k6LtfNgZLaEdV2YHYYBiCPCxl7AKdExjOk
	 jPNUOzlJpTPzw2QYRF1/5VYPoc+s4X4zQuaHpUv6Bv7iME9nhDtrGqftq+XjrX7RLIy4u
	 L4PeSjt3gqQFzBoXjjh6XZBjRGvgj6L8ouUcQNeJbuMQWQ0GipOFYaFh13mB8DpnTJQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790042527;
	bh=CCgVdZT4+kNKzAIY//UwujioMlQ41ec/eQyAshwKgTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hfD0szLR8q1dXBGOEWlF4Z9bax+5WmXFCJ5xJErZ7q9NLzyIpunfazu5sd2zXizn7
	 /PuLZ8AHu7PgHsypdxfOeW6jMzRLm7zdE7FGQnPce78CjaGVZA/nMzEzH4gHP8kiga
	 qg2gW4347u31XLnbDjD7V8PlezMtYA9tVXIrGi1daGYytdQGetFb1y8JBFJXNqdbM9
	 cHFg3jiq6xCko8b+SzuxFDTzTy6yecPH3iCGeK59DFYMI9CpGqEen5u5VylFg8K0T4
	 iOOui9M5x+jScceIOfxP+yH//wZ+Wa5d3X53rYraFktYWc8hFLz+PkNBrfQaYlvdAt
	 76qgA5CYrbWUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FA4C80DCC;
	Tue, 22 Sep 2026 02:02:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2430E352
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15FE46066E
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:02:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b7BrpgHUf5wV for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 02:02:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 714CB60668
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790042525;
 b=cZI9DY0ZhgNHG11exuTD7mhly70AAEYGMIFXgt8YwFfCcKZPLHWqA/xvRRIucHZ6FJMb
 xtNC1mcKuBZeH+ru7XnSpnxnx+9tW+YeYAqV3ZTBWk2lBzw43f8WgXyTNx6Bd5wYOhMmc
 5md8Hn4ccjvN07VIdANDVBqyVCOwE/7dFScOfDUXJxD1raMEommdOy2/HrqJ4ru9wrxkY
 M6I8xl/di5l7sItY+x3IzTvb4dM6UUTdv66gWwwosA+CE3XF1Ckx1P6QjZR85/wCsgVZV
 24vEFmMZZWu+dSKflABNHsAbr3dCQFRkOILIMiYBKp1tVpkFGhcr20PHOCJEgKJtvVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790042525;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=CCgVdZT4+kNKzAIY//UwujioMlQ41ec/eQyAshwKgTA=;
 b=lA5U5tbPclG1HzH/02VqQJrxajQok1UCJTxDhde3oL59WjV7Ku1mPmHoh6FlB4Tvhve2
 bT5vsW7yN33nsYtIMkZZZ2BJgraEpsdmXZGZ0pTpHznFzLJJlTq9pyD0JSbvZf4y81O+f
 GGm6P3aaQ7LvDpSxaBDJXWfb7fyDRQBMd+S32laNIvCA8aDqTG8alVjUfm9ISUFyifvs8
 gXrRTdZvUmvb1BLFW4fRL2s+nEToxqOaxHplyaMgr8RDPB8jJqlepN2OUShbA9uc83vS7
 C1a/6WezlrC0QRHAelgNoJscmq73TFL5OMESIsQTLbUritizvEY12SQwZfDf01doruA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WLFE9vL6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=hungen3108@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WLFE9vL6
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 714CB60668
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:02:04 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so2743127a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 19:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790042524; x=1790647324;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CCgVdZT4+kNKzAIY//UwujioMlQ41ec/eQyAshwKgTA=;
 b=WLFE9vL6y4ztBMl6NQvzC+bXT2bxWIzeYeT/3E/8ErQbIV//Z4DG7Z/8I2JuD9QyPT
 di09PbTUFWfjsf5NOBsl5C3GqLRExuPquUSFCe91QfSIrCouMHGCDglm9VQF2y8cSMEO
 DcJiDLM9FT/pzh3Agx8+UMaFow9crUygggzD4d5F9ddDPHGbMPeRR2WKg7PNZ0BElo7t
 eb4EOoCtO+TJ6CMz43vcjHd+gbnVqRUF9d10x2fseTIr3tv2kei/sHAXSDrfqftT1dV2
 u0/wqCsHJXTa0QcgwdoOX21yf+gJWPcxnI4DLfqFDFOAC+BOSBwZEMdRJeSyPNY7grxS
 B/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790042524; x=1790647324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CCgVdZT4+kNKzAIY//UwujioMlQ41ec/eQyAshwKgTA=;
 b=cgJcLnEIiTjSkeqpF6TRJJajzrQeiRSgRaYUiakzJecdWnxOL5wWschxOuSRF78wsB
 IUtr+qNkIfMYOPJwo5hl+YaU/i0MEEqA+5FKQLDGv41XALgnnP6HFBJHoCMbEo+kC0Dh
 09qW3zmnagWYDWD57BChbEsCiFNdSY3F69uSySUHRaOdZSZq3S8Eg4cLmZRjI5DPbxgK
 tWnPVs1xhumuzXKbamXhbMazcDeXZ9HLVf8ERkk3h2TA8eXDo9xmYQHD4cFM8S4K35gj
 Lp4S0pVsQFL5e845/zi4X6unjBwACBt5eT0Awiitk2dBtsRiGtpi6CoUmutcYs+Yp6uh
 6kOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkfC6pnXYFnysFCRl2ZYEJa1wtChmIWAOC7MYWY8p8a6fBO2cLSWoxGwobGGZETgOHGfzQcKo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ntW1AzDc1Jc6evhw/lvDWEaE9FGb57WqSnPAWhRV8dw5AonPl+
 lFPGo4/SMTorwAW7TaGaMc1r4CtN1Na+5/4SUfTj4oIFPcx5o1AbkvKS
X-Gm-Gg: AYBFou2H3kBefGxqEGaVZWRfQULFoUk88tJnG04lqZW+nbEQN4o7oU7jm6H25FxVQOZ
 x10vT7hB4kothcaZ9O55dz8lghKVL58WPLDJBU+KT+I/XhmHY2l+uANiDfIfpjlAzpkQtGbiVMY
 ht3EbaybP0ijCIyN8NIbTq+C5WOUl4G0JvIWl/4ZCD9Q/76djgn+ObUaVElWNWwUCnq20rNiHfk
 Zt2KwEke4jKT973CQCt8H8hrRRQxL4+4w7D9PCCcYJAMyY+VjCCJHemJRXc1/KiETt/9gKzd1mt
 ZDfgceJ/AV7rvCR/0vJoDylV0IbWYR+RRLmRh4Goa3d6/0Qq7uEh9SGbXhvTygjYod4+j0GbwCM
 HZ92Rcpb1VRxI7wpsRaPUZQvM3SAy/9MRe3iWZnyxJdWao0BwgbKVKBVyclVPeuuARihggGLKrt
 /14IHIM7FVmz0arTMCIrvCFOCDb/yru4xwdaw59mWF2SYhfw7r6SYygauEmPF96n52wuuJMWANN
 2zxrfJb/81KvkpJOiPs9kva2LptBbv9ozEWYkG8sG9xanBv5QYudUZRjxHLeyr8T3d7jba4DwA1
 Mo69cMP/
X-Received: by 2002:a17:90b:57c5:b0:39e:3554:4d0e with SMTP id
 98e67ed59e1d1-39e54c584c7mr24855947a91.1.1790042523899; 
 Mon, 21 Sep 2026 19:02:03 -0700 (PDT)
Received: from pc130107.ADVANTECH.CORP (118-163-147-185.hinet-ip.hinet.net.
 [118.163.147.185]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a06cb41b39sm215236a91.3.2026.09.21.19.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 19:02:03 -0700 (PDT)
From: Tom Hsieh <hungen3108@gmail.com>
To: eichest@gmail.com,
	stefan.eichenberger@toradex.com
Cc: marek.vasut@mailbox.org, marek.vasut+usb@mailbox.org, trini@konsulko.com,
 hayashi.kunihiko@socionext.com, u-boot@lists.u-boot-project.org,
 Tom.Hsieh@advantech.com
Subject: Re: [PATCH v1] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
Date: Tue, 22 Sep 2026 10:01:51 +0800
Message-ID: <20260922020151.1847627-1-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916182012.151031-1-eichest@gmail.com>
References: <20260916182012.151031-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Stefan,

I tested your patch on i.MX95 (Advantech AOM-2521), with a GL3523 hub
connected to the DWC3 root port.

The board is not supported in mainline, so testing was done on NXP BSP
u-boot-imx 2026.04 (lf_v2026.04). Compared with your patch's mainline
pre-image, the BSP dwc3-generic.c differs only in board_usb_init() /
board_usb_cleanup() hooks and glue ops linkage and const qualifiers,
all outside the ref-clock code.

The ref-clock hunks applied exactly; only the dwc3_generic_remove()
hunk needed a six-line offset and fuzz 1. I replaced my local ref-clock
fix with your patch, keeping the other five BSP patches unchanged.

After "usb start":

  GUCTL  0x4c10c12c = 0x0a404010    REFCLKPER    = 41
  GFLADJ 0x4c10c630 = 0x0a87f000    REFCLK_FLADJ = 2032, 240MHZDECR = 10

These fields match the expected values for a 24 MHz reference.
GFLADJ also matches the value Linux programs on this board. Earlier
testing of an unfixed build gave 821 / 2 / 28 when the 32.768 kHz clock
was selected.

Both halves of the GL3523 now enumerate, the USB 3.2 half at 5 Gb/s and
the USB 2.1 half at 480 Mb/s. The 480 Mb/s half previously failed with
"Device not responding to set address"; that error is absent with your
patch.

The added clk_enable() also works for the SCMI reference clock on this
board. There is no "failed to enable ref clock" message, and "clk dump"
shows the 24 MHz clock's usecount increasing from 0 to 1:

  before "usb start":   24000000   0   scmi-2
  after  "usb start":   24000000   1   osc24m

Testing covered boot-time hub enumeration; no USB storage device was
attached, and the remove path was not exercised.

Tested-by: Tom Hsieh <Tom.Hsieh@advantech.com>

Regards,
Tom
