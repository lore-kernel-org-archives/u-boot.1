Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B774C5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 18:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26D6560747;
	Sun, 23 Aug 2026 18:58:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0E1QkIrcaIuf; Sun, 23 Aug 2026 18:58:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787511497;
	bh=Bg4nmr3JWmrVhzG6U6x0e2qQArc9robvnOy4tJpH3QY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xgUGUgPjBpHyJMmFhvIIwWHR/qlO1mqLO+Kx2qF91M0c7iyod2J5JcwfMUrJ3Blg1
	 9Yk5eUaDUApLJNeIjp1Rj0m39p9n0QA6W50Wy4y7ZFisCXXzytf9kNFBizE0Mh5SYF
	 BmG9ZOg2kJE2UTcMzIatQekJL7bqGg0ZEfR3WkWJDDibElpYB1PqZ38sx3Uvd3oeIp
	 LJNIp7U3dSinM4AwjxPzQox0KCUa9vBfC97I8yXroDNrvy4Xi87TEMVa7zxhhFaJOq
	 pstjQ5qi8IMz/EhPQZgjfWORdj2lNolwfP9mic5Ffod2mpLigxgHLzwzFrr8ze7W6O
	 DrJB659uCLliQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1792660737;
	Sun, 23 Aug 2026 18:58:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 21E73386
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 18:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07B7C606C5
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 18:44:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9xaCgiTm1ASQ for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 18:44:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=M+3YEYdN
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A5BD6060B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 18:44:46 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a09571dd5cso535854a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 11:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787510685; cv=none;
 d=google.com; s=arc-20260327;
 b=sri1xm10MNCoMvlpxqN5E+f2beLz0MUMe44HVU3QVLpwLAkCAMmdRFizmbxppN9fO9
 4VN7L1/7jr5HmBHCXobNQmfbHlRBTn9iMNL1tPwL2ZiGUDfQ+YYSbr9jDlNoxhNMb09/
 PbTr5jn6FBzMOLeV4LbN2usoilnsOsg1MkV7xFU73uyTx0dzT8fjbgYe9jJYr+PRxt1t
 2rQCna+vYdhY2byxDivSial+37ZCpWplOfnZzYPyOBnPqobWIflfhDbyo9TuJCZVR2T3
 P0nyUCKm6MfceFIQa0IqNUGqQy57YAQT5kzVcIDWexPlqL6qifvcZ/rBUVAAdXKHkL27
 BVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bg4nmr3JWmrVhzG6U6x0e2qQArc9robvnOy4tJpH3QY=;
 fh=fmtMrLLsfalAbo02pCxPO0F6lLrkVJuJJFgA4RWqucw=;
 b=c3p6c2eUbLKoRO+58VbECXce+7QJqhb3z+uFQjDqMdwpHTjXzgaCNhw59IeQGe1iLY
 0jexYcFhHIonGCE+K6kpWajbfzjxTD41I//R75+y2+lY0JMTVlkoruQhT6t5ItfYW8+a
 UDmwn2vPsrs98RWadFsST4ydIcMozJ0voTvq5VTEBcruFbxeUROTfBxfVJA1E1hXR/34
 Ka+mgQQ7h8rHasERwOs+JlR/sAvKumCSrLRQZGQpcLUs9emtHZHWZt2UV0OQLkwmGuc3
 UD13hVv3cwpyDJfvIKI/MD6XOjPUgkCAyFZToZ+JraJgkE5MiGxUjbIk1kG7K2yyG6jc
 EBQw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787510685; x=1788115485;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bg4nmr3JWmrVhzG6U6x0e2qQArc9robvnOy4tJpH3QY=;
 b=M+3YEYdN3fgpK3JNh4pW4w3PXoaOXeiMYTcEvk34c4S2V5+h+ZZejRWqmrjzh7v0c4
 rTARqYUSXR4tpkISpVumrLzSumnrj/1PxbsyyFPq5yiOhsFEsowgQv5NDn+qUs2VpANf
 jJ0Qreer4y4KEE/YcBvB0CLLnlcv/tPIymQln23BtmrpIdSqSQFN3G0XUgdV0BbjXqYQ
 G7NbwKyPSNw4iLX0zQNZtbEgAuTYFmpIKDTpctOGBrX1DJR8M2/KowbCKCDwfijkSKeK
 1AJweFjffPqBE64fdnT/EsUvuSiPuL0F1P7FmCZ3dYw+89QrS/xwziOz55tZnUDaPOnV
 EWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787510685; x=1788115485;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Bg4nmr3JWmrVhzG6U6x0e2qQArc9robvnOy4tJpH3QY=;
 b=YbyA6vZst4D+n43j3Q9Ipgnvl1abpBoaXKcklsCJWZeb1FXU3QmRjcJcpoasfjEbFa
 waAY8KoOhgFGz2YCa815+etFf6rLc9L+0JGaY+i0XgDA6SiYeOZ33eGvcV12onv4iELi
 LdMmMNy15tX02r7rYJuOisFSuRa/4kl7nMgGplOoQg39uTUDzsWVq1wKqo5rGYJZsDz0
 kb4mJffYz3ZqlqVeJKE9z+IKJZR9IXZFZ4tYYNSf3jY7x70vSegn3MN7tcWbml3flA3H
 iBWk+r1goteBYTrRimh5svVSnT6Cx92VROLS9fsFiwuezLxXVGcNcYWZEewQEhaKsTCg
 19WQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkxbSaIrUfiSbqnw7iSQL2BGKzUt31B2JzMExlU00ZRJijVz5wEQ8tC5phyMCsJAMvKDEnKjM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kYVKOFitRVtds6Ultw55PoQ1q1zNz0t4NOkprW+Mw09Q1Poy5/
 jJWV7Fp1kHFfBnq0Ucs7VB0hhdRymIlGmxAr8KgeIIZeoyX2mD/tsvHWpotMzaFMxvFC+bx7kt4
 vnLyldeKgoX/zUVmmuHsuPK63vUQnZf9oVTWnVSZX9w==
X-Gm-Gg: AR+sD10Segsv8j+A1hCtLO0FGNPCdmiEqsWbqZL9WAxaSP3vOBJnLtNLZOee2ImDXU5
 08jKlOKvD3fQHbZtqwVUVgQZotdBTFBLzaOPRu5eoOAxGzgbLMf7Po4OetfSyQfea0gffoNrKvX
 q0K7gqFWOShPPQDSSW48ceFQ+21SJmNbFTH0PQBCTC24XobJNMbcwqw+6jVLmkksRZHotHOvPOz
 I+IlYR1zGmwX5WjmjlDIDBceIkTUanzNx2OHUdPLgBLHY6IzMVj4bQ9sWvYjXdMHv7hsH/bhIsw
 JbhQmgPd25G5X1sma1RcidKD2v26nRZTsIKq7HBpjhM=
X-Received: by 2002:a17:907:cd0e:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c246a63d6b3mr1328623166b.4.1787510684413; Sun, 23 Aug 2026
 11:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
 <20260821084829.2070426-2-anders.roxell@linaro.org>
 <20260821194451.GA3890585@bill-the-cat>
 <a4ff5d24-9da3-44ad-934c-8a8b0caaad42@mailbox.org>
In-Reply-To: <a4ff5d24-9da3-44ad-934c-8a8b0caaad42@mailbox.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sun, 23 Aug 2026 20:44:33 +0200
X-Gm-Features: AcwNN1W9J30AXGKfw8ZCkvOVtZYCCR908VegYfyf9Sq4GVJxGw2iWGq5EFQR96A
Message-ID: <CADYN=9KBebUKhgwkvZ__EO8vjktsP+-cA=FuryObWpn5eGpysg@mail.gmail.com>
Subject: Re: [PATCH v6 01/87] usb: host: re-import xhci-ext-caps.h from kernel
 v6.16
To: Marek Vasut <marek.vasut@mailbox.org>, trini@konsulko.com
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 alchark@flipper.net, jerome.forissier@arm.com, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 23 Aug 2026 18:58:12 +0000
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

Hi Marek, Tom,

I'm sorry, my send died in the middle, gmail locked me out, so the
cover letter and the last patches never went out. Marek, the tree
is at https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v6.
Tom, yes to the split: 01-63 import, 64-87 make it work. The import
patches are unchanged since v5. I will fix the cc list for v7.

Cheers,
Anders

On Sat, 22 Aug 2026 at 09:56, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 8/21/26 9:44 PM, Tom Rini wrote:
> > On Fri, Aug 21, 2026 at 10:46:37AM +0200, Anders Roxell wrote:
> >
> >> From: Jerome Forissier <jerome.forissier@linaro.org>
> >>
> >> Import drivers/usb/host/xhci-ext-caps.h from Linux v6.16. The file
> >> is needed by the updated DWC3 code.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> >> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> >
> > For the current series, the cover letter is missing in lore, and the
> > last 3 patches are missing everywhere. I think at this point we should
> > split this up as:
> > 1. A series that resets the driver, and brings it to v6.16. These
> > haven't changed in a few iterations of the current series, aside from
> > collecting tags, yes?
> > 2. A series that makes it all work again.
> >
> > When being merged, both will be required, but this split will I think
> > make review and iterations easier for everyone. Also, for the next
> > go-round, please drop some of the old email addresses. Thanks.
> One more thing -- is there a git tree with the current state of the series ?
