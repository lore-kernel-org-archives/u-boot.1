Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1D606A324
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eCHuKaU7;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wmgBlbs0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEF00407C5;
	Tue, 27 Oct 2026 16:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_1t6IDYQry6; Tue, 27 Oct 2026 16:01:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 05CE3407C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793116910;
	b=NOS+WBXcf/XWOFryYsz4mwbpKRlInsVn4v1YAZ7jyNMtVYn4HFF5wl2mbD0FoZSAoJWq
	 PmYDqHiqcBj+ub9yoVF/3ujReoJ8Yg9j8Qyq7AyVVlJ9YFIWLSb+tpFhnur7vr/6bHXr7
	 QShqH9z5Xe7hNpGVtrdPFbF2ar+cT/k5m8m0abG25epNnmMOSBGhUOFczheEdrXhwPyau
	 Ug/Bp0orXvIMFWlx3JhxtRSMz02blEMgrCMAahBSGJbyxpNSvyjTkEMUX3q/bqJn6q8L7
	 PqimN+8d6gnV8k7pduyoSmNcExfqjiWq4JCaOXQihTKOzWIkZxGnj37kTObN6sWSNSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793116910;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CdiYQmNmAKtGibqc6liCqTC5Ef3Y4EEYN0YrwR03/hY=;
	b=Up4Cf2eR4+CGyBrc0s3chg6nxcA1yvHTgOvT2MNB20DuOot4zDbf6PSsajWthYd//6VJ
	 4KvEW+5KWpw1W8pgv1RsUIZH0BYwJOcJyBRlPD4VW+MRX09Y/VVpeimO2WAPSI18EXz83
	 CZDbQ5dhPsHyzzj/Dae4YWw3WGMfC5NtS3+uTSOcRfYwbOcvWDzij4oYDaL0ObkhT7EXz
	 uZ0oTSw8/9GXdk+g3bYn5yACE31bsg24slGswSWl3V+jAZtj9CU/4MBNhb1dRqMDniAMz
	 NGhXoWni1Mpg8kbFCu3F9aAm53SXSQeuNyBntH+hgei/iibLgiVyEsPY5wnPU3yLLMg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793116910;
	bh=CdiYQmNmAKtGibqc6liCqTC5Ef3Y4EEYN0YrwR03/hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eCHuKaU7Ez1icU8OyzLiEEzZM7Vadl6jK4ORfYBZITqyAkYJJqRaG5u7aavPAoNiJ
	 vlKdrBmvCWDhE1wCaBlil7ZmVqaQEAh+af7E+7VK3s3MBuy7yBrNHcgvZvS0UCcDSV
	 r9OTL49jk/h33p90GihvPlPKAE3Ga8mvcS2C9IfRAw9FqpMs7ITgipF8vQxUBFe+Vo
	 faWxCjeqVcvOl5kTkePPps/zSuAGM57iVOR+Fe96gWhti74ca3iQQdZQMzXMjFM5mE
	 m6wlLIKsiG+R5QG6Cal/38mZHHRVUuZ+4IW9yl3ceq+1RPlGzEsUo6zbGuzkHqoYwV
	 Sbg+EwPifrFSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05CE3407C7;
	Tue, 27 Oct 2026 16:01:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F21B9A32
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:24:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3C0680BD4
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynh_p2osBVhg for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:24:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D8BF080B7D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793111089;
 b=PtKJ5isKFQObor17oUqIolIEboEOhPYkbm2oU60ATJZvymJEre3ziOzhYS50zp8DyTQU
 Ta4e7z9OlQAIAdxN/dHxtae3qygUC+5+8/dhnpNlqe8RwnYCFhbYbAhiBfxyjCr9/bdYw
 pS8bp94xSSKl21r1rh6i+yWAw7tzIQmLfY7KKtPvUEWntDlqr7eibKoLuOWrEqdEfxBr9
 F/TJGMFBHrJoQn//GA4Z/8DRSdu9cbzWbBi2ZfJDDgSh8RDftZapVhm/mrEzQ29tForOq
 K5zqg6ypsjSVeS8Ywl/9l4V22hx8lTDuqXAfIUmHaUxRlXMU4Nb0GzLfkhWBNoGsanQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793111089;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=CdiYQmNmAKtGibqc6liCqTC5Ef3Y4EEYN0YrwR03/hY=;
 b=U3oIdqE9yUJspq/66BlygvfEO57DNcxcTMjMiMb/6wG2DktTZKsj8EJGKMrh+rOycbO+
 mHEDUQL/Avo1IK5ku0W6R5U/cNCsEKKco+vIG1Rhh8jl9RqXKKxOsm0+EtLR7Ecb282F4
 4gZ+oMWPv9pNKCXvj8yA3ZO0nQzuJ67hgnUye+yt4UDHDNgum4NhIUS8IeFHJT6gJ6RW6
 z30WFJFQIPtOG9xQ11+ei6+JcXQmo5FaCSXsA8Q8iOHo12UdrE4mL1ywq/g4ZlSIwp0Pn
 IIqfNk0WVBj6oBsHCfkfMPE13Ng/yxKT9tc9+PD2yfCHDWOimEebOFQspUxgjiEEE+A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wmgBlbs0; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wmgBlbs0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8BF080B7D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:24:48 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6aa046a99c6so1031057a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793111086; x=1793715886;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CdiYQmNmAKtGibqc6liCqTC5Ef3Y4EEYN0YrwR03/hY=;
 b=wmgBlbs0YVVuxV1yzl6Uixx/yyFWpvcSXXpN9MlQH+o0mGNUzZG74pxvg6gDd1UxEI
 4nmigwUC8GB4uF4plbg71KglFF7Fxkd51B1nzsS/o0WwBX2upX/mLd+U1NOgaJK1Hi4k
 M5gt3/sfQKV/NPl682tiv4GwlBbSy4WKhn4R6K3CGyOmzbvYBRkGaxHBfZjul4AAqvRl
 CWYb8TeVqx1gsfZri53sYgCkkWI9NKjEItlEQDMfm/ck32DhPfSh66KUm3UthdTBml5T
 T4KL5Qn+nuCoZCxZ08r4EtIBvGwBl8Z+pw82D6bAgN08PwynV+wKfN+euBMqn+DXKzC+
 uAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111086; x=1793715886;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CdiYQmNmAKtGibqc6liCqTC5Ef3Y4EEYN0YrwR03/hY=;
 b=W/z4z45aN6pCaumLAwsLrq1MRoLhSKJ53vDAuSTwMrLZV0SPEvn49anZq3ZQI8113D
 6AfDD6tp1h1XsfOzr2VGwNpaCIsZVgJ8ZC1LtauvVPW/IkMaG6TDLCJrHyIuZvMLM9/E
 ad+8xIMKdEcdnBx4OAuT+8nKwcG0k1vLXJh4UgBpm3SznEhK339LF4iB4HiJcvmzP6HD
 1MLZOzrMj/epOWKgiSsS6xTJJp6bjxmSUlCoM3G4MNq9Q8Igw65DTddNt7qTo0qx5/i+
 X4VXxnb5FAAprsiQL0lU0AQLI2cWm9rjngaSM2UNiNPnaftj+GnQTy/d5LS3fZsOyZd8
 ccGQ==
X-Gm-Message-State: AFq9FYL4/XctaMHwSzUqZ4EV28/NiqHthRShd2v/JW4dsj/onYBK2+/0
 SwIsDOlAwgFN67YeFz/y9OT3zOa7RmRsPL/MKUPB//M7aYbidOfJteQqtLc+5VBV814=
X-Gm-Gg: AYBFou3rwmh00/TeYkKso0loJLVF27o+VY7eQDUNLqwUkrVOUw5p0Pj6+vtxbCQSeSB
 djgwFsLzz8t0aeSad3rioUIe7g8j3W/0FYQyQs3hPlQ2qd3c90t/+Rb0fkgFguSJNQ2tpBuuw/9
 pF3VZlc76v7tEwCYu7CQnHfQUBAJtPLLG4XJFbumUQXWgBBAFMYskrfM4VyaE2RwhRLqEeJXKI2
 IZl336N0UW5yRUGB5+GGzvxSwn4sQkkerL3NI4ojpxOswI7SfeKulEx3QlYkAjtmBM+048dRS93
 LINqff7cuEv6iEY8mBy71CE6q87+0DMza7UxF7cW/u41MXvpA8Qvoy7yyNmBOuvp2Bu8TchluMU
 iHj+4i6UtCqakT704BRZJQ3JPlI2ex6xU8SvD/Hht1ecUOYf9cNI1h26CRiAczxfzStnDVqaKvC
 UQhmxe8gB42BsEMP85OeibPcLCpb1kjvOxjaWrI/c6wsTVwJycehsZRdIpe2FMUyU8kZJqpePWb
 4PHXyyRBS179ACEXaVrC8UIqOY2i72rlkhsfskN+2wq4qqKndGiynCoPaZOgdXR3/hqzaCewCzb
 7jLDXaEhe8gbeH/ggr8hVDbGASWhdHf6Lw==
X-Received: by 2002:a05:6402:b16:b0:6b1:a509:8a2 with SMTP id
 4fb4d7f45d1cf-6b442fc33c4mr10626124a12.2.1793111086145; 
 Tue, 27 Oct 2026 07:24:46 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b495ac43d5sm154579a12.3.2026.10.27.07.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:24:45 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:24:43 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@denx.de,
 alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com
Subject: Re: [PATCH v9 09/26] usb: gadget: udc: enable async callbacks on bind
Message-ID: <auC0K3ig-2ZDzdfR@monster>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <20260916123826.517181-10-anders.roxell@linaro.org>
 <b82cb67a-03ff-4c27-bbe9-882b37276310@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b82cb67a-03ff-4c27-bbe9-882b37276310@mailbox.org>
X-Mailman-Approved-At: Tue, 27 Oct 2026 16:01:48 +0000
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-17 13:43, Marek Vasut wrote:
> On 9/16/26 2:38 PM, Anders Roxell wrote:
> > The dwc3 driver was synced from Linux v6.16. The new ep0 code only calls
> > the gadget driver setup() when dwc->async_callbacks is set. In Linux the
> > udc core sets this flag after udc_start. U-Boot never did.
> > 
> > Without the flag every delegated control request, like GET_DESCRIPTOR,
> > returns -EINVAL and ep0 stalls. The device never enumerates, so fastboot,
> > DFU and UMS do not work on any dwc3 board.
> > 
> > Enable async callbacks after udc_start, and disable them on unbind, the
> > same way Linux does it.
> > 
> > Reported-by: Anshul Dalal <anshuld@ti.com>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >   drivers/usb/gadget/udc/udc-core.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> > index a01a7e6dc21f..79f249cbb114 100644
> > --- a/drivers/usb/gadget/udc/udc-core.c
> > +++ b/drivers/usb/gadget/udc/udc-core.c
> > @@ -949,6 +949,8 @@ static inline void usb_gadget_udc_set_speed(struct usb_udc *udc,
> >   		gadget->ops->udc_set_speed(gadget, s);
> >   }
> > +static inline void usb_gadget_enable_async_callbacks(struct usb_udc *udc);
> 
> Maybe this can be replaced by moving the function instead ?

Yes. In v10 the udc-core build patch adds udc_bind_to_driver() below
the async callback helpers, so this patch only adds the two calls.

Cheers,
Anders
