Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DEDC5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 14:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B08840987;
	Sat, 15 Aug 2026 14:05:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NlJOmeHSFTHS; Sat, 15 Aug 2026 14:05:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C731408BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786802741;
	bh=5Jd3ZtfEGvx+S6V96brf6oWIwKZ1gyujMtk3ruHybFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pDnd4GaRlcpIaZw8u9p9qsB+5yjjuBn/oEO5eOivN3JgR33KrTkt0GqZ1UvDuL9/w
	 crAcY3Los0oFYmH0idDEPMecOs53FSbNPgyVcmsmpmDrjY1zrP8/vgenB2KdkvS2fb
	 LElBrPxoR8hzrR/tfP/L0jstPy+Q+xhA0kYClgoganw6z7MeuqOxNbpbEsOSxxtERc
	 mLwqUO5Ol9cqtjtydQvwu48ejW1k5jBL9OSCugZCFhHh7x1iRJL0AunS7rYph96LNa
	 IHGLNNzPPuQNY0MheamaHAqR5D5ScfEM7s8ooE6sZ9sRkj7lCCGiVdGDOn63045dL/
	 ZIYmeoTzpRyBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C731408BA;
	Sat, 15 Aug 2026 14:05:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 17CCE2BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 14:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0928880F18
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 14:05:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sub3z8i0UPjl for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 14:05:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3CA8E80F45
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CA8E80F45
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sqA/+Hvx
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CA8E80F45
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 14:05:38 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-934956bee57so202865585a.2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786802738; x=1787407538;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5Jd3ZtfEGvx+S6V96brf6oWIwKZ1gyujMtk3ruHybFk=;
 b=sqA/+HvxTgfSD+NLz5/AoMGxzlXv3cvtfX3To09MOOQfwPkMUOcRD7H1Z248mquRLQ
 tl8bVM89y8tRc5mZCnGUyc+W7PvdnGNf4cN1EnuGtf0eDpFOUibe8Y9rGtsxETFTtM66
 2knVrTcgQn0haM1sCn+bcE4sqVH5Z9tMzjHEFJyWv0YExw2VYpeEcJ1fxXC4rc3P13Qs
 k2Ws1t5QfcbjjZfGBacxhEk81ByYL5FYwmWuwRUICG0PZwZm9bllZJpjDMvKw+0P2fE/
 SmEXW6mZLYkdYo18cOaAYdUaArvCVPxtKmhm7JHbuaBXzz9hacHs9zvcXz6HDqanTsFN
 03bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786802738; x=1787407538;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Jd3ZtfEGvx+S6V96brf6oWIwKZ1gyujMtk3ruHybFk=;
 b=NdK2L6ZnO6rePsQ21vxbzaZ1uc/2+tNgxalPATDhs5z3bMDR7GdsBwjbyP1yltH+C+
 8ybcSnm1JWU6hFSVmTRckBK+NLAn4Tb1AQ/Bu4dUEELh3qpZPTtOcf/5dZyJVID3EKEn
 daAhURsuatsgUVlAxCtx6konQKPfywJeEO/kUrkw2a5LMBdLYZO2nRpZRgU5IM7Hd0ZN
 lFUqc9WuhKYwP4VYfECy3oCFaw6Ff1K6LIsi2ZCf20QX1RDhiRw9DFf8QAEfoHJtrGgl
 asl5QE1ofWUCPSV1AhqtNBbcHzVTm4FKHbXlmt1za0IN/7vJFvCIjb5YOWmeB2nDJSTm
 2nyA==
X-Gm-Message-State: AOJu0YxYNWkOgHwG6X2n6bKEAL8r1Dy8DHgCy99LNV92FZsT0Ffu/jUM
 zaAW/X40kWhpRpM2wvbE3JqnhWB1zrKfcx2yJolk7Cjx3dz45hoLh06TK4Da1lSRJSA=
X-Gm-Gg: AR+sD11sOk1L9iW8vdeBVoJqA3ls9/OHYHip7blfC3Lgueu8Zti/MKeu23MCeMG5nKo
 LyRGnWRcLd5U5esRXeHjztM7wNaluNq5LEEjIbJx5nUHvJ2+NnzcQs2PC2fNCISeJbBJbUZhlPA
 FFjb0HzODUBKIVSHnkupZonoCVibAwQN8J37HJvx7F7yINVutP8MJatn9yiTz9tocZxTs0NdL+N
 3ffltBdm6rVCOzHI6ilhGxwf/XTs7sBGg8pmzg6GCOPDMfx72h5VPMRriadFgSh8erdgj79u/p/
 YQQolGlv9L8M99KSi1Jo0BNuvDxKnmcUFAX2anb3poBOBBJ4+idYni/h2Wd8XYWyt7SgTyAZhvM
 L8iSGyjJEep7l0Ns0GBwAYoKk/Hr6jouYD84a5xBsDoCbmBcLZ8iww3779cgEQk/4RLYoNjq5Zn
 3/P9LmxL32qbSvIONDmlndbgj72dFBrE4QfBczSc8hh7S9589WiQJjeXK1DikmGlxk9jujBtIaO
 508ThhesN1fSxnlFaIvILuohW69byBjqiRAxAy4UGI=
X-Received: by 2002:a05:620a:d8d:b0:936:cdd5:35fb with SMTP id
 af79cd13be357-936d227a606mr1363704285a.11.1786802737671; 
 Sat, 15 Aug 2026 07:05:37 -0700 (PDT)
Received: from localhost ([66.129.139.8]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce1ec714sm549728085a.24.2026.08.15.07.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 07:05:37 -0700 (PDT)
Date: Sat, 15 Aug 2026 10:05:36 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] gpio: dwapb_gpio: Enable all clocks
Message-ID: <aoByMCnVSX_GyuU5@maple.netwinder.org>
References: <20260814-rzn1-2026-10-gpio-v2-1-7490cc61b337@linaro.org>
 <9eb93d89-41f9-4c9b-a876-22e6f496443a@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9eb93d89-41f9-4c9b-a876-22e6f496443a@mailbox.org>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sat, Aug 15, 2026 at 12:05:55AM +0200, Marek Vasut wrote:
>On 8/14/26 8:29 PM, Ralph Siemsen wrote:
>
>[...]
>
>>@@ -132,12 +134,34 @@ static int gpio_dwapb_reset(struct udevice *dev)
>>  	return 0;
>>  }
>>+static int gpio_dwapb_enable_optional_clocks(struct udevice *dev)
>>+{
>>+	struct gpio_dwapb_priv *priv = dev_get_priv(dev);
>>+	int ret;
>>+
>>+	ret = clk_get_bulk(dev, &priv->clks);
>>+	if (ret) {
>>+		/* Clocks are optional */
>>+		if (ret != -ENOENT)
>>+			dev_err(dev, "Failed to get clocks: %d\n", ret);
>>+		return ret;
>>+	}
>>+
>>+	ret = clk_enable_bulk(&priv->clks);
>>+	if (ret)
>>+		dev_err(dev, "Failed to enable clocks: %d\n", ret);
>>+
>>+	return ret;
>>+}
>>+
>>  static int gpio_dwapb_probe(struct udevice *dev)
>>  {
>>  	struct gpio_dev_priv *priv = dev_get_uclass_priv(dev);
>>  	struct gpio_dwapb_plat *plat = dev_get_plat(dev);
>>  	if (!plat) {
>>+		gpio_dwapb_enable_optional_clocks(dev);

>Error is not propagated from this call.

This was intentional. All existing users work without explicitly 
enabling the clock. They probably do it in board specific code, or in a 
previous boot stage.

While adding clk_enable() should be harmless, what if it fails on some 
of the existing boards? I would rather not break them, this can be quite 
hard to debug.

>Fail path that would disable the clock is missing in this function.

Okay, I can add this.

Ralph
