Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472F9C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 15:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0BFC80848;
	Thu, 17 Sep 2026 15:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfOfdxOteDo2; Thu, 17 Sep 2026 15:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3B75580880
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789657633;
	b=ZF3PdQBHLHKPNGJjxrJkHMbiG36yNMDPsuMjaYzDpp0hUHNDsi+oT5qOrr2YlCFD7Vv1
	 bLtoXP1yUhdvNN8kmY6Sk+QrtJohMyCPUcm2Fm+JbQ8PgucdCZfuFpoAFbrB8C4rjrDLi
	 y+JgBcJMFQ4s3pneKHs1cAP1pqgtqmQX8mYjcr42Ib/7xezfwG+QukgSTMtlwox3f9JYk
	 zBgxHLpwiff3J8mQRqRBOh5rcl7fkPsDKoNQsz2K18GatmvRzmgWC6lpd+10OeEVAoKxP
	 XYUajSxDRmY7W44j6V3XKHIIgjuUZ1o0gBLcbEusQGxPjqxzC6ihYG8UNqVi/iYIorw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789657633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=A92ZwX2wkaKZl5bGg0/tuOkIUvpmjgmxQyJwGbSdXls=;
	b=XJPX9gHlrk+XIhdriJh49x3onsg/U0K3nmFT2B9+FRoDR23iTgTXgDsY35mYDoWsyQ4e
	 1O2ULDYJP0n+BuN3/cPlRx+Rj132fWQ2gbFDTxe1iumnfhubzPbE/Mjg6QyZD6+emOpz/
	 BvhtrKfCdSyQlnlIzPBeSQCF64gE4PFJVUB6ZFucgvhDEFdg5Gt+e5g1Rh3T4UPBIrBD1
	 rPev27wPpvXzt0mCJ44LqlHiSN4v4kfnegCTb7WHOrxf8UoBdSUpwLi8k3BvFvUoD22xX
	 ul/51f0FU9mB4e5tx/zLly1YNW3o2/l+dd62VERjvOuJW6MGUAUrjX6iNZr193NX0Tw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789657633;
	bh=A92ZwX2wkaKZl5bGg0/tuOkIUvpmjgmxQyJwGbSdXls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zKp132hXuzNYN+uh4M0MFIzoezLwlSFHwfUPqslrcn2rra2cGNe+3SxYloold99E3
	 2PkSOKZhjiRoXWd8qAaJJ4vf67f1MbHS9v/HPiMJPIn9w+IxvgHUTx1UxCLyvK5xXg
	 BL+j8rOpDm0Pk2AHZiEaL77pxZ0Ewk9z9qPkDAc0pruAb+ehJs7yACZgN/Qvo37MbM
	 YDTm8ug/c+0RmYdSaOhtFPbHeiciVg0bVRCmveeb96wTBJXJauW+Lxo2Ey0A0c833Y
	 7Q0ROc7yuZFmOuUJO68rHq1gEc/XLrZFrkK73jrAvysmKXLwMBy31G6pK6mjOceUDk
	 QgZ8zSc3m8Cxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B75580880;
	Thu, 17 Sep 2026 15:07:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85165362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7678F4027C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:24:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Co4reg5nfcQj for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:24:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 86D504037B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789655066;
 b=R8MWbCtcFw4+ElMOpsw7izlvH5EPuUMlEHhS3Pjdr1aempVaQCNMrwsONgl9gLiQYIzX
 aaeURU15bSbEVKLYTnv7ysog+caQ2rRyaxnafPQmIcldJqCeiwqI8CDY/RVBQUzXPvL48
 T6DHSqqGGsr1exEmsu2wgbQJwyi07TlysjOCfmB7Q928jCD8vI4bgZ7YbVlfRuBZQIku9
 ovlhpPbwFdNrpIRTnLigj3ACRNc8FEXoz/nW0rf6DiCiq5upW6UWOqCV1sCCWUSHi7qHw
 neNGaOLk2ieGkxMNHKgzdJyh6GgmkAveuyWIiJVK5KPR9/d9WKDKxkOnnYfvSAacMNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789655066;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=A92ZwX2wkaKZl5bGg0/tuOkIUvpmjgmxQyJwGbSdXls=;
 b=EdPsWPc6tmtYC7WNE61aAHz24OEhx8TziyNSCcwHrNJVrnSP9s/7knkUJzdRVB/EgJr/
 bNkCca9ayy8Je4jeTqC/gZ3DTcK3cCmYi0EnhMjezdmphPJfAGo6VQNRjumJrEeoBPHRw
 7iRlrR32HDolwaiwKz4EgddmKM4KVt+RToDLh2Nn3aNpd0NgiR+UlkIeOfqVtLrTrM10X
 Y/bQUtxm0Z2CfWr5aljLrsCIatCAHt9JTJUDVYtnA6n9/PoFZk9O/tyb2C9sw2ODjeGEZ
 Ylcb886Ep5fby3tJfpAphLQYWkOdJea03gddrXnLRhxQ2rREf865tWfI86B1HmDDgXw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JR6U0v70; 
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::10; helo=mail-lf2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=JR6U0v70
Received: from mail-lf2-x10.google.com (mail-lf2-x10.google.com
 [IPv6:2a00:1450:4864:36::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86D504037B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:24:24 +0000 (UTC)
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f16c72so714980e87.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789655062; x=1790259862;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A92ZwX2wkaKZl5bGg0/tuOkIUvpmjgmxQyJwGbSdXls=;
 b=JR6U0v70f3tZuJb7mEbXVSTcWqt2j864dvthN2UzdJNUQWasx6F2+oO0fnS5MzfJ4I
 BzMabjP4CoE3HPOtcKMBQLlRgOJS74AUUdYm2UJEccPVZFm3ty4JaWITQCTMj4oCR6+G
 PIrm9YcWw3O7DyX/eUnkKNWrdl8g20KobA9q1iSsOM6bIG6EKTwCa+GcbP7I6GI3W3w2
 07IHvKsi8uFI4i2AEQwNOg7iMoOEEGdM1ffv+orIFf2FqWr8JWPNIATmkD18lcqYk56s
 iMz4bF/oEj24iiOP/nuS18ZOKC+fKZRCmuGMhWKvgQmDQxbZ6I3ueue2cBF8Z0MWWdni
 Rd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789655062; x=1790259862;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A92ZwX2wkaKZl5bGg0/tuOkIUvpmjgmxQyJwGbSdXls=;
 b=vGfvy7zUfEGNRf/VLxc9WpAHEBYcBhvPasBzn1P3TQZ/PZ2zVLckw0/EYsq2v4csND
 4TpqpXBzvEw9gndwa74sjpx0EuZPqe14IAlb+h/88iNGdN3R0cKu+VSecyPytBTEnpaV
 xhnRKQrSRgcVALyMV4w4zXQX3kAdFl2ASwRIHkhqz9t+He+QdFSzGIddMvIUP4Wq+c8C
 i9LwAz+C11DarNKjJhAetfr3zT1aPBtmJ7EaPIXl4mblJ78O7/CXxP22r+kUQGubpklH
 cs6QNAZJBNrgQUHW+EnRgG8VaCPL/gXVRzUB+pRbIusSPLmxhNrlICEwtCm9B1B2RDn5
 aiEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwxwFPN29xMkBiLLMq8P8UFiK7tTxB1G80i4MJxZ/Lt4Ntko/iHe5QZw9TCToyN/9GdbkGAnQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kV1grtak/bSoNrRfl5jlg+dQf9BhLt8E/3JD2SxV9iQAMgCANQ
 a0TWBq/ybMPh1z6jGv3lYu16sK3fy7s8/RVaZSZmoP+J+flJW3OsoiuRTPsCIQ==
X-Gm-Gg: AYBFou1H0PzLlg+U6bubVQGxTYM97cJmZHHyaB+U5zwORb7p0PXTfztD9esXNwy79BM
 MR94HddNuIEDueU3dL6gwwZfXJ9ivR3Sm+vrF/cdtv2mEV/vQikIy4nAwuY9RJXvmqhtFlE6vfS
 66z3HHaelPP12f80SFXM06Jtr3ukfZelFVWPqfntHvI17q8IJhA8DrImtRhbEY8nh0jdSDPFw5Q
 oSYWTJvsAAwv16xIQm4JNCl5z9Vj/DYLsMcD5EY+bm9KfRQf639beymZR0MH+VZM4yx3vygEFyQ
 5wxvHY0norXimI+qEFIaqKWoUVNLKZr7FlalGZUsVl4RBsgQPTXPvCJtsM/oT9uUKBA73YC61lF
 MBSyISr4+Hy944EK7HQ6KeIa4e+zFwq9NwKTm/pFvSoxZq2Pay2yDtugYkSDVkSj1nVMRslXhYH
 l72I8BZ5+5lXiTS71A35ACGMjz3hFXhaWzAHdID/2EW3Y8qrf+LQ==
X-Received: by 2002:a05:6512:3a8a:b0:5b6:1a7c:fd89 with SMTP id
 2adb3069b0e04-5b8b665fc69mr1867526e87.47.1789655061902; 
 Thu, 17 Sep 2026 07:24:21 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8b57cc336sm1881298e87.30.2026.09.17.07.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:24:21 -0700 (PDT)
Date: Thu, 17 Sep 2026 16:24:19 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: marek.vasut+usb@mailbox.org, trini@konsulko.com,
 stefan.eichenberger@toradex.com, hayashi.kunihiko@socionext.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1] usb: dwc3-generic: fix ref clock lookup indexing
 wrong clk_bulk array
Message-ID: <aqv4E71pN0Mihiu7@eichest-laptop>
References: <20260916182012.151031-1-eichest@gmail.com>
 <a9392e75-ee7b-4662-bb5b-94626a490a36@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9392e75-ee7b-4662-bb5b-94626a490a36@mailbox.org>
X-Mailman-Approved-At: Thu, 17 Sep 2026 15:07:06 +0000
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

On Wed, Sep 16, 2026 at 10:43:50PM +0200, Marek Vasut wrote:
> On 9/16/26 8:16 PM, Stefan Eichenberger wrote:
> 
> Hello Stefan,
> 
> > +	rc = clk_get_by_name(dev, "ref", &clk);
> > +	if (rc)
> > +		rc = clk_get_by_name(dev, "ref_clk", &clk);
> > +	if (rc)
> > +		rc = clk_get_by_name(dev->parent, "ref", &clk);
> 
> One small nitpick -- would it make sense to validate whether the parent node
> has "dwc3" or "snps" in its compatible string, so this wouldn't accidentally
> attempt to grab clock of some completely unrelated bus node ?
> 

I'm not sure if this is necessary, or indeed if it would make things
worse. For example, ti,am62-usb would not match even if it relied on the
fallback for the ref clock. The same applies to samsung,exynos990.dtsi,
which uses "samsung,exynos850-dwusb3". This would mean we would have to
list all the possible compatible strings, which would be difficult to
maintain.

Regards,
Stefan
