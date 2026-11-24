Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A9606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YsQ/n10Y;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ndde+ixl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D03C40642;
	Tue, 24 Nov 2026 10:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z5kIt5Kt7HuM; Tue, 24 Nov 2026 10:02:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F311140665
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795514573;
	b=jKASni3Lfog4AXM5xGT+mGN+h48ZJEjmI7T71Ydi1LFto/Nkngt7d+fhv+I1hLAlKbO9
	 7cLrY6dYu0T+ZLG1Hhc4dWv5dUctzvD1nuoMis/7QcaFM6HRrWG6Lm1WtwgcqCizHdW2Z
	 eCW/iUTz6RfUhpt+9og/PYrPajjiENSdKCYfq9+atKx9HBGqsHeERqoICoB3cuzgJ8rX9
	 Es74xVJueTbHdE7pgzzjWIIJMRh5wKDp3wnf/RW/crzg2HngC3+hydbi0sJQl8EFlWt6I
	 PuraO09S1jHFpgtfWoy/FpLN+/zG3Kz49Vc3p42RExrIgGhdgNnr4HFQxGQ1eTzy2OA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795514573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+KF2VlGDZAjzbhYMb/V/z5ImUiC7feEp1J1uSa7q6Tw=;
	b=LR9cmSbaHhTYpe+FjEbKEqd64Jw9wBkYMA//9o8zsnq77Q5EdUEH7RZ4Zt1ZcFAgsmab
	 LScbPWzWrDl2ZLxFlk4g4Hf45KoeynkJPbSXRRUjryeU3s+QSFm7MSVOW82POBuThRiSj
	 zmfsj1lBhMilkTv+kIS9l3pB9rsaSPZygj9I46XSlZXKtmrYj7g7y1mZNso6rrgP6bw4y
	 rB6EURkxp8+4TjaeMbX1Q4Fq0+Uo6EYf6UIpZGX08f5jHGAS2wgU3bryorqzHHh4s/Olq
	 qhRYpv3a/2ZxkSl99Ox06AsfWm48vNcMUGoiO+bVV82x5RMeRJQfJ4/ZYUhDOuF6hEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795514573;
	bh=+KF2VlGDZAjzbhYMb/V/z5ImUiC7feEp1J1uSa7q6Tw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YsQ/n10YGMtLZ022U5QsuaZ38nRiOwQEFesOiggRNBdRS6bCIdc+yJO8OkeIL7EyB
	 j8UCjOTUPy7b/5DF8uovjUITVnS8kEiQPqoQecBToyOHXkqicMBufBBsjURFP1YkUB
	 d/3xLXGcc8pXBpELJTswVpA4Eta0FXBJ+akvbhsSnvFXZwNGRDX+oZUWrnBoI4Kq+u
	 KTvPXEDcrNh+5cyK1TW7P/6d73FK9AT6p/O1Qgzt8ttJXRmKdrH1DBPfm+0C7yo8B5
	 uB4eeW6OUOgOErZS9QwqAaVUIjH9tz46qRtG9QHCbbDtFBJQtxS/99TsgZmTjBIWAq
	 dv5rG9tiMEorA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F311140665;
	Tue, 24 Nov 2026 10:02:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 948203C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A6E540068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 43cldwppzlR5 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 10:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 87A9240048
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Ndde+ixl
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87A9240048
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:02:50 +0000 (UTC)
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-677bc4704cbso5017279d50.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 02:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795514569; x=1796119369;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+KF2VlGDZAjzbhYMb/V/z5ImUiC7feEp1J1uSa7q6Tw=;
 b=Ndde+ixlCIwyXTGqL/nSRpOOEfwpHPxXq3kuVx0KR+9C4wBF3bWg0tyo0xeO2QocIE
 EJ11wONqlwDtQlcyHlXPsEoS4m6Gh1YB4o27gd8N8JwYhw5uc5ulI9OZBaqwRDa+ns/r
 z2LkGW6WsnLK+pumyVxbJeBXwUsnt4IwNsWQr/eB3rdwrPVrA19ZM6dY3OWKBtuLcw7O
 aO4+lcrmCMzfMe8Y3jQndGLAizTodevTkNn2Wk33bqRrR5umW1XWIxSi5zsMGj4Gri72
 kxGbbBwjTGTIiDIQds0Je/XihpPL3mpNtWKkIIMWme8f2jlLSOw4KHpkC6DRm3+SGATN
 BHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795514569; x=1796119369;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+KF2VlGDZAjzbhYMb/V/z5ImUiC7feEp1J1uSa7q6Tw=;
 b=vaFFLE8Ti+EuioU2RfTQZ6TZ/kfnjFCQ9NLMC4aqsaF6VIWFFFn522e0nHZ2wcgSVV
 HvDomj4DheJM4CFNDTWqHrXlZjWPjdrp/iMgOcONkggdVMx2I81DwjoyzpjGnYVxJAxj
 ZqGJ7/Q/9Kl5CwhbkqDzKFoNe6K7Ne9xZai+hEJjIQY7EwO/b7Bg8/UNfvFwAwn4sCMV
 EcgPO3+t0yFuFaY91dM8TGtPF4iozDIwIZKCQC9mOO3zpWJNwU+i1kMzYeClh3wFCb+Q
 Mkr7YIKpoifl4UgnpjxWNbUOI04StxiulTJtBqulpl2SZSL1/9x+N6iKfZHboVUX7III
 /REA==
X-Gm-Message-State: APuU4Z/M+eUU12RCH7+5yM7HWbj9RSy4zsP2K1dVGeUxprxJaeQye9Az
 D8KMLyRvLKzHiwkq4lWnJSioWOLCCxFu9fnx6mG+yiT6ugVhaGchTWSaCmrg64TvRO7XITmJtNz
 r6+Hwtw35KrXppfNC4KnKDD26PF/nkx2CHmzWVbJgpw==
X-Gm-Gg: AZFdTZctMg7ybtzDmMEMOZMphtv3Tv0NoZcsTkZoeWOUKFxvirKZtCC7x5LU+xItb/i
 D2xGUUla6vVjpW7F5JW1CuChjgCZOZ2h12hKfL0JwK00r90EgKwHsJPrx7CbsERugKCO5aVheBP
 k3ZNE/+UH8z6DsAwl1WRgmu9CKiKNnEP1cDOKqSsWqYXui3gPd5HS1SrFUfNgk0faf9bCx5Av24
 YUvnve7cw0oF79ePCJFnh9ILCUPKj0dWF2CRNBt55fAl7vNwJ8hKCGvOvpR7gvXOkiYE5gfx7a8
 WsK5ughh62HGBzjZc/VQ30TysaELcfknt8478x1Y3LOt285Jo4KLug6YPe3rITAmFruT3SZH+72
 9m5GSJYpNaHb/Mj+YI1IoZUiAArW6dWcaDo1E6H8s2y52k2kZH58Q3cuJKasyQJ6PKo6leb9/px
 E8vu5+BNFXGoGS18288UntXnUNNBGVj+drpW/tneb44iH3xVQ0AroBGuZu1OCzQWfNJJfi24xNi
 W3KvvLpRzpNvW6ZrwRk0VqqqSp+QObhnErwCtIg5TF1VBCd1JukUhflvytZKL/fPUtGiOUNk9ce
 tPK4tusI4KCSQOJhYASbtmQQKHm4bHuLX87cQLK8x4ladPcPeY3RWfwLB4qaec7UFPmY0e0gXoE
 91x5/NsMwZ7pjUFrR0MEDusjYVUJIeLejAQTEUxGJK2R6wluTnePxPxYhsI8J/7abVbJprkTY3W
 YHg/XClNWjPKYSjA+7waKNjfdJg6kWdE8JUWgP6pEtLz3dhwlUDndHntgEQHLSjHV8NcsYxJo=
X-Received: by 2002:a05:690e:408d:b0:67d:c305:ca1f with SMTP id
 956f58d0204a3-67df43f32b9mr4741432d50.53.1795514568907; Tue, 24 Nov 2026
 02:02:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
 <20261111-genio720-ufs-rpmb-minimal-v1-3-701a62dfa034@baylibre.com>
 <CAC_iWj+OikJL7w6ye5U29fyE-h=HU0bEaXqq9w4g+w+OEty1NQ@mail.gmail.com>
 <avRaNHH9CTO_-K_e@macbook.homenet.telecomitalia.it>
In-Reply-To: <avRaNHH9CTO_-K_e@macbook.homenet.telecomitalia.it>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Nov 2026 12:02:12 +0200
X-Gm-Features: Aa3M54pObJBDSvVHboUadLvH4HtGhTCXw9DTFRgHqDBdiuqxTT_3chu4LzpNKT8
Message-ID: <CAC_iWj+zE_qGDTbe8MgxiJZ=0RQZDyGS7Zn3v=fEFCg=2o7pRw@mail.gmail.com>
Subject: Re: [PATCH 3/7] tee: optee: keep UFS RPMB discovery state consistent
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 at 15:05, Carlo Caione <ccaione@baylibre.com> wrote:
>
> On Wed, Nov 11, 2026 at 13:44:51 +0100, Ilias Apalodimas wrote:
> > Hi Carlo,
>
> Hi Ilias,
>
> > On Wed, 11 Nov 2026 at 12:21, Carlo Caione <ccaione@baylibre.com> wrote:
> > >
> > > Reject frame requests until discovery selects a region, and invalidate
> > > that selection on every discovery failure. Keep the cursor on a region
> > > whose metadata read failed so a retry does not silently skip it.
> > >
> >
> > The commit message does not explain why any of the above is needed.
>
> fair enough. It is probably a bit of a defensive hardening but it was
> something I stumbled upon that felt wrong, not actually (hopefully?)
> seen in normal OP-TEE operations but it is supposed to catch discovery
> errors and out-of-order RPC sequences.
>
> If you feel this is a bit excessive, I can drop it from V2.

Unless we can prove it can happen I don't see why tit would help us.
Did you have a use case you could reproduce it?

Thanks
/Ilias
>
> Thanks,
>
> --
> Carlo Caione
