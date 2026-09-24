Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C57C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 13:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AADC440D86;
	Thu, 24 Sep 2026 13:01:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bCFERxhhQFpI; Thu, 24 Sep 2026 13:01:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 583A340CD1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790254888;
	b=SvHYgmXnSgm4JfJs5t3Avq2m1hMmqGlIcIaN6VaYA6Mktbcp7mVNpbn4+GOrJPp0CKke
	 CIFpOMzvgZ++I1rSBfY9uOXAvkBiaEzOnjNGYufrQNTbGydVuBQ9dogA9wzCS509mYrlx
	 bkVSgKd0aYAIVgGHXYYj0v1GUwJtM39Fr3Ip1LckEZQ0Y29MeccImzqgCtmTPhkLClHKx
	 3ks7twMEqNmWSkf7kJcPZDE7DQuV9+X0Rl9/kN+8RkjZcwpez5XXizQma5kZwLT8SUPXi
	 DR7vjYLF50BOTqMsNBhPVz9rpLekP900RnxozEEqk8X+/wH4yHW5g+R8eeJRBlwpo8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790254888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U4IHcFvnO0ZaXeu5F9mpgqfXy3UC+bPGBMdAvNPhoRU=;
	b=ZGw9dhqlSoN3IdYrZRUPL8UqcxZfdrGPil7S7KPCcyCW14QWn9PPS+Kaus3aFv1YaWe+
	 VgdDvkIR3Yd6Uk0efmxhdPOPjt6s+nMrJqBSW7m0RbmQtmkqAUUM9hINQbvbCghvg9Qwb
	 N0WKcUgjPZL/Dbu9s4+C5Hh8GfAHM7TERRiv0gK++EiRytvGo3D0GZsTDuE6G4PbPaBXi
	 Wq7Kfg2/2IC+bwo59bFUyTcKFa8P6k1EMgy9WY6uKyD9UUsYavnxZbmJlSmdolU1/SjiS
	 BI+WNULWc78wuX7jSkbO1bg7LX+Sh9tUEfbiwReiIs5IZpqeS+9stnbLpP3lRkpaINw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790254888;
	bh=U4IHcFvnO0ZaXeu5F9mpgqfXy3UC+bPGBMdAvNPhoRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jZ6T1X3pLO5HBCVxqvdjpK9TKNmRlK54CLD3iqtBGOsmPv7F+a9ZDPFy9czPYwFHK
	 4gEwZGo5vpU//74gf+sr/XJjEjaZOxjZDddWW1g3h9qBQH2l0jbX0+hXtA9Qdp5vQG
	 ndtMiolBpUBtG6E7AmtVXtr6GhmWcrxZNU67NFyNTvTQcnKdFQXWRLpEUpkWkYE8Kh
	 liO/BeJW3vGLtRxMVc4bNrQQerF/vwzw2ZGYH8+5RG40WTVBjll8UAQy58UqqN6VKS
	 d+xuAPyiTzHFgNeRfNg/SJ6I6cA223vidITKLoFyylRd9YeyCys205RtYyZQb4udyC
	 Rke8DBuNo7wtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 583A340CD1;
	Thu, 24 Sep 2026 13:01:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 216DA3B7
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1339660805
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:51:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZgswtGJ42DQc for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:51:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 135B5607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790254310;
 b=Gn1r1vpslOJvJ3GC5UUzLo2jXzwOrGPEefZGfBZrTGrjtkEdyckypFyidSMQ1aYrFEFr
 KeCxG08RzVHzXwHWZ9WV9fn6DrFto6iHhl0ZUHKW1Nl/43N2WRPbJyrOAgmFislZB7QsM
 mzlrlwFeyyerhvaBxH0DKSAOM81OuxlHhnpKXV2QJIWHtEQuf128F3n+TTdZBgbc/bGtT
 JPfzpOhDWDduk4YSy5Y4KMCoN2LzhlOrqz00NPZfgQrgqN36K8UdOYyF39iHYV5ATqWgP
 0cqCeaE32gOMaFajuRB6qJp2N72aq3ZOr/xyaWCU+NHNNi96GCGDMROBMwYuxfQy6CQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790254310;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=U4IHcFvnO0ZaXeu5F9mpgqfXy3UC+bPGBMdAvNPhoRU=;
 b=BjyfldtIbNGemh+s3GPZ3zItmSJRt0Ea+EI0yCrjd/WHlA2DW30/HVbk3ad0WCqgYYvJ
 UMBsG2IvWYa/ta6iVxdr1BBACsCpTe33PphMwSmx/e2TvAnhqdUFxQp73802Tz3JOqfOC
 tznGLLx70941k4ObplbFdt6/m+0LG6bzj+MUoUOhPoQOEJfTVtNQCDeTQwerpyywuG4k8
 2BxH7j4PVbyg45cec7dpLwjmQb366MtkC6ulBTeJaXCBCZ017ZiPsC6YHxXz1xyXlz2ce
 tSBErap5s1h3r9/ta100IrflFpZrjF6qIlK3Pal9EJu5Z6vcpxDKS69iSAOOT9tokcQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eoj0cefW; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=eoj0cefW
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 135B5607E4
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:51:49 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so1289238f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790254308; x=1790859108;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U4IHcFvnO0ZaXeu5F9mpgqfXy3UC+bPGBMdAvNPhoRU=;
 b=eoj0cefWIdRNK3Nx4zJGljple6vDWs3xB9LMkDTeEV0CMcxeYvlZ7PoR+a4Z6nANZi
 YVuedxraYy2PaGhABSWWSiIfddruZrLqOAxz5l97cIg/P0XP7Sznr8gZEbX8lUBABtka
 hogfkhoiIclxyiLO4erHKOuET66YnwpC2imMLrXdDJqpi+EbbT1Bc9BMGwlro+0M7ovR
 nQrl+IdrHAL51OZkX9f7TSRdJWQ1EzJx1/TKbPwqYFPIhYQSPcBmzCSkD3pL+oiuqTnC
 FGTy+VFHy8kI8YHco5+hsd1w9YfLV3a7fyzTxmXME33iEeSOd2al+tDcQBpeXDGMfuog
 fNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790254308; x=1790859108;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U4IHcFvnO0ZaXeu5F9mpgqfXy3UC+bPGBMdAvNPhoRU=;
 b=Or/EMH+N4Jl4eajwjwnZa9k8suyCZexfOECfyBEU4XysNdPX9ahEFiSQ+r8a8C19TI
 +aKM1U5PgBkt0hgVJTB3d6XGb5ZLfpm2z22QQ+82JeZ0pWt3nskRJM/9zO5eH2Qg/YPl
 bGewmUAqeoyUZHx2l0cmkc2V1oTahz5w2Po/EK9jsYJ0cbHDtGt0ysDjOs3egmilVfm2
 pXwrp1EkQB1i4tjsTvwS0OfgJkatkeJDL9LIO0VNncc0xRb4SgvFSLaXZYCBgho6FKIZ
 Ir+dQRFcSDsMQ81DoBA9YfzJMK3W9g8dnh8DOd3PHhp2Eoej1Ax//wWj3ub0Sm4pYqGP
 M2Tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRhIBrZTg3tj4F2t3pEEBU/2ZNkkDJ5LYc6Z6ev0qw6UYufnTK1j5T0Xx0uD8iDKSgt71AzKY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kkq3h/Wu0xmyjtjZ6AyiVn+vhp99VZvonhsNeY2fut2oO7qU1e
 sslTeKkoNXaZYcKi3JuOyLAY3fiGpTZy1E/Zf4HvTXoHkLncRSsSU7qE
X-Gm-Gg: AYBFou2qVyQ1U8GRMTFKPrlh+BG3rWr01EPZ1b8qyZ9+aadQwM+WdT3vCev5r6Qy/mK
 XAnImQ5BVtJdEYQ/A9WbIPY2Z9E3hjAvBf3wb6g5nMB/mHrZxMcPIf9XVtfOig1EQ8sucUxCp7Z
 CpyyHTqfnItLELe8HvRuGS4F0VoBsILxa0r5VWbM1DPY1rdjlefCEf017ZEEELAlUOT4U95OQTQ
 2IxyQomB6rL1u2EeRahMuJww2BXG8cmg87rmQHGKfM5EvPeMhQvsgRaX7dGwhncGW0cA2V0hJ5C
 uwOUvFdBlQg8qaIjMtWaeWw5BlA2TevNg+8jQDayDAZX5Pl8V8Vt6iPybGairtHQj4Vcf04ro6d
 z5x/CobxYZz0n5ubNIZfXvJIp6XdVRp4dspBCbWPsD6X0nGex8vaPHxWBP/7QWWk4h0IlKYflBj
 4BemmzQohzGu8NghDkS27iTsbs2pIxyxC+e5kV6p+4kyp9SjtQbqWhNheIATe/et63P8sF4Tje2
 s5IstAmnryJVVe1QHfbdO+kepmx+aP4crLYaE9sJjz/KPxkrBCN/eE7JQ==
X-Received: by 2002:a05:6000:288a:b0:487:35d:cb0f with SMTP id
 ffacd0b85a97d-488717165b1mr4709157f8f.14.1790254307466; 
 Thu, 24 Sep 2026 05:51:47 -0700 (PDT)
Received: from eichest-laptop
 (146.151.63.81.static.wline.lns.sme.cust.swisscom.ch. [81.63.151.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488684862a3sm13363515f8f.7.2026.09.24.05.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 05:51:46 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:51:45 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: marek.vasut+usb@mailbox.org, trini@konsulko.com,
 mkorpershoek@kernel.org, stefan.eichenberger@toradex.com,
 hayashi.kunihiko@socionext.com, Tom.Hsieh@advantech.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] usb: dwc3-generic: fix ref clock lookup indexing
 wrong clk_bulk array
Message-ID: <arUc4cNrKbx71ms7@eichest-laptop>
References: <20260922204329.311571-1-eichest@gmail.com>
 <65e822e4-5edd-4d48-8bdd-f7a614925a73@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e822e4-5edd-4d48-8bdd-f7a614925a73@mailbox.org>
X-Mailman-Approved-At: Thu, 24 Sep 2026 13:01:26 +0000
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

Hi Marek,

On Wed, Sep 23, 2026 at 03:30:44PM +0200, Marek Vasut wrote:
> On 9/22/26 10:42 PM, Stefan Eichenberger wrote:
> 
> Hello Stefan,
> 
> > +	rc = clk_get_by_name(dev, "ref", &clk);
> > +	if (rc)
> > +		rc = clk_get_by_name(dev, "ref_clk", &clk);
> > +	/*
> > +	 * Only fall back to the parent node's clocks if the parent is a
> > +	 * dwc3 glue wrapper. When the generic node is a top level node,
> > +	 * the parent is not the glue device but a bus or the root device,
> > +	 * and its clocks are unrelated to the controller.
> > +	 */
> > +	if (rc && dev->parent && strstr(dev->parent->driver->name, "dwc3")) {
> 
> Could dev->parent->driver be NULL ?
> 

It should never be NULL. This could only happen when we define it in the
root node but then it should never bind. However, I guess it's better to
be safe and check for NULL anyways in case something is really wrong. I
will add the check in the next version.

> > +		rc = clk_get_by_name(dev->parent, "ref", &clk);
> > +		if (rc)
> > +			rc = clk_get_by_name(dev->parent, "ref_clk", &clk);
> > +	}
> > +	if (!rc) {
> > +		priv->ref_clk = clk;
> > +
> > +		rc = clk_enable(&priv->ref_clk);
> > +		if (rc && rc != -ENOSYS)
> > +			dev_warn(dev, "failed to enable ref clock: %d\n", rc);
> 
> Shouldn't the driver fail to probe if clock cannot be enabled ?

Yes that makes sense, I will change that in the next version.

Regards,
Stefan
