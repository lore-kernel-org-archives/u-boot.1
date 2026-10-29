Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06666606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Iub2l7+Y;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpO11G8p
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C35726069F;
	Thu, 29 Oct 2026 11:37:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UX5cKAzqWw3h; Thu, 29 Oct 2026 11:37:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2506E606BD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793273827;
	b=kYdpAZwtv22U5KeTuE1GeNBzgPpPFoDboQ8yMFLt+/Aipdf3vYfS6uAi69ZQRWHYo4jL
	 FvDgJafbBEHHcvvnRXRS5ElJJTjW82oTaS9J0Z9qNnbhYpFBzHOkoG/uhQ671XNVR6Swx
	 cDYkHIEWN0pSJDISn61QPukv4NbaXBCAWZaznsq3jQSF61rtzkl8OJhVhO1dS6ueCxRzl
	 QJQ/SF6ohxujHe0NfoGuyaIW1idqd85nCbSadh4jAmVUs3q8SlLD6Rcja5lb9d0ft3NLi
	 YdyIhTqQVYZFjNadUeZF54IkuTgAfRFKfwulKwO8z8wRdQQbiR/wPkzRSVnUFoLbhrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793273827;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TzF2zsxSnoimgBLHmVGKW8q6k9jqsfpVQNs8pwrc36Q=;
	b=Rf99rAHQWPMzsjpNRFlqp9gf2Xtq9ylY+wFhqhJo1/zBfP+CaRgWO1wvGu80QGYSXnLI
	 B6MJhvENB6eoApeVx3z0qz/+ilp85gHPni8i8M+Go5fm2gnDksdFbdlD/1sd+ZdCdzdul
	 sF4Smvmr7AvGlYyFL/8Lbb+HME+BE21Jfj4yXwBnSkIfNYivnluq+wHKm/VBaBwIIyy+p
	 Rvcfnx4x2MZGAOH5zyellyjktBnm5qM4lxZMITkZEk4STVc2zEzRKIpL25KpISLqZkk0/
	 klbgsSKY58GztLn/a+G+tbUNXt8EXOTYf/C8bj5vRfeDsF+rtF3G9Ftb/i4fVt615jg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793273827;
	bh=TzF2zsxSnoimgBLHmVGKW8q6k9jqsfpVQNs8pwrc36Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iub2l7+Y1RNyBfXqqbLa9vb0IwfEDFfdzYQyC1dd06h74qA+hX0Gfxnypgm/g7ZlZ
	 lqCS80pcM6fLVA3dCWVBZPgEuUT+venm+dsUZrW2PwISE/xK8l+Y2cMTVe5w7yaj3l
	 +KEgKhRxkIz/B8q6Zs7c6BFfWGG7KGJLgv/gbPv0oRPFKllE1V4Nzc0IL/0QVKQJXO
	 nn67rDrnt59puOL5fW1QQPyChe56K41KWDbLF0LCUKJ2LT8SYVEW4AWoFppqrFa5KB
	 NpcXRva0BsrEy3qDQmErY9exzKgU+oq7uDn9c8R48gy18vJdb936p0LXD5NEywIVLF
	 acmYx77svleHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2506E606BD;
	Thu, 29 Oct 2026 11:37:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 60831972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 469964032E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:37:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SQzSb56LIl0H for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 11:37:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9392A40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793273824;
 b=SAoT3fO8I4MI03Nq8mKxPDuq8pPuvZbL8AqX4F/nX7+wcDKwkS9mFKy+5WJvqnS2XCzz
 UE2eTEr/T2GIO118QCLRutA6HbLX8kgXLv0RHf80LgOhbB6RWc5JmfCdoAlsg8FUJDlVP
 E1R5DSZwSGhlhOCJQEynsaqkldSrrEEeUj1kHxmm9gWtSjZwTrpRwv7OUwP0Jw2jNXlU+
 gdYuwn6zh2eJ3Wt6G8+2dtkoEpQ7mt/pLIdqBvmSLef7XpGZbpU/z19249e8e6ZWvJTgu
 GSqBL7/A/xjSw1mX53QieiXjYR0hyrJ4D8SS8G+pWn3rXSQRVsJ4VrQqG0QeDoKwiSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793273824;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=TzF2zsxSnoimgBLHmVGKW8q6k9jqsfpVQNs8pwrc36Q=;
 b=ljZBTstAaO9mAGf4ckuVRfHtiTHzCM3fWTSBzm9nHHip+oK8KNhQkWarxomSK5h95fAr
 gb6AOReJvNC5EK5GS98yrrNGXkyCr+grG9uV49joX5t95zZhV97K3bYEGUQ3tT3SVswz7
 B/dfSuOfp8jpr37BoVdeWnKR3/BhzaioOIvd7gCWwD5b8/dPNmFucYKlTj+/ORVZy6Xa2
 +b1ILj0T5UZ1KZpYPpces9X5EfN7zYPsf/Udk4f1Bzmzpocj3J6XZGjCm+zL62mYAkQsu
 FZ2xOzsn30rYUYvhAp5TY/MWykEouW+vWep8Xr1vPoQ/M2uUswqzP3Y5JXfWIFYlatw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=kpO11G8p; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=kpO11G8p
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9392A40024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:37:02 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-5363c8de563so23889401cf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793273821; x=1793878621;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TzF2zsxSnoimgBLHmVGKW8q6k9jqsfpVQNs8pwrc36Q=;
 b=kpO11G8p1vpPaimktwtGumZ5/UxTYP7qZskU6VGgT2rzprmn4S2ZNUz06kpeeZmNbz
 97Xp7im6Pw9U6vt/Te4vcGDdq2ruyhBbbgWF2bGXJJ6IwQrF18AsJpvFt6DFLRe4Kh85
 QuxVyvjG8Yc/nPhuXgAeX0Zc5wTDqmhFZlYO2bX007I/uDwISTZmzFQz06aeF5/hQbyN
 ebZHSsJJg+Qivgx88bjnoaT9NtOBh43O8yN8HGWofxR9KLZfwYxsBiH/58ClVUgMMdbK
 PImSZWNEiO6GBsq83aNyq2mrSEBaLNCPWSJYZUNVlEhbWV3QwHqpbjJbnAo1W4gOycg5
 udPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793273821; x=1793878621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TzF2zsxSnoimgBLHmVGKW8q6k9jqsfpVQNs8pwrc36Q=;
 b=iF7va/B3q0jA4PDMjAkl7hWpMWMw7WHrQD63aJh23rcsTdtzXAmqSgV1MkaJ2Skoe3
 ERFS2kKJTFNK45yKyH6UfLrmr8+7NzZVctBpIl1R9w22Yg3hLO9RBDlHlQCLMJxOcg83
 KdrWv/b+lTtP/r4ZkvU48rn9D3uP1Z5X5G1tIyABrmdHZPfjsV+wT3qkbt429Z4FZSq2
 tuSR8em4sCYsDSQ7+OPX5xURF9PY/1kBMEuVL35YvudTv6UzMZ9V1T5KZd6U4FkxTmYI
 w2v62SnUXtNPvaIedl4gWj1do92YzTtYl1OrQdXXr7hFfRkUWhlS+pQeg4pSZpwpCEOR
 dKng==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdwfNgaZr3TSUpvdfi2+omlT3JjMu2pRSo++OCIscS7Rf+jEekzOnThklIYWPjHZg0XSenIrg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKEwY/B2obXX6EA2495afiaTEQuIYCHnRWFbKsqV3FgX5dTe232
 dmDCfR96aat0/yZ1ln7+gToNOxgEK32ALdLod/FuO+0Ck90rYaVROcPD
X-Gm-Gg: AYBFou3UurH+khtQiSfcRipYz9oAedKhi/sElNqWrXcvVLuxL5tv3d1vubt3txbucOy
 UcbL2MecKPNkKIXHwikIzBShknJ//rj0PeUw1z4oH+u9pRJXK4lIarEknWYjlnnW++rhElB4NRP
 M1c/s+aAQrHAvfJ1qJbQnknSf+3gIw/zEhnMBsK6ZTPt8SMqVMlAb9idBGmmAx55/Y5csYC+TDt
 XN4IrnH5u+ugjUCZa9WuxZtmMzHWVlG9BGvcFuGxy4KuXbQKSS1GP3pUCP5TIaEWcZm5+2TKiqk
 q20eBPejd7PeU2cVwp2VgF2GexhjmrOBigiqHEaCfDKNRz9omUFMlEQdcJvxAvHa8Jl8TmPKmyo
 H+al8pJTrknx5N7qqnCVwnBz6/cxMQmASnkTgtKv7qgGtOzFHcEPeWXeOWUNqogoN4LKgryH3BB
 e7LdmAARe6G5OSsTBooBM8NeysPBM64ogP0JmGQDrYjTisetSmu7SNuz6i+5I0+cTtukzuDZXp+
 AYBG1Va9YfeSPnnN0C7V0D7JjAr0r4JEZ4bgMrQ9dU8n4DoyI5305b5gVCCoclQZOpRUpv0Cifr
 sHGCbdKH+4LqcOBvMPoVF1LxzD8HhLWSIjg=
X-Received: by 2002:a05:622a:1824:b0:533:920d:7bf8 with SMTP id
 d75a77b69052e-53fcbaef7e8mr81879121cf.24.1793273821204; 
 Thu, 29 Oct 2026 04:37:01 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5383970ab61sm127547691cf.17.2026.10.29.04.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 04:37:00 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marex@nabladev.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 mehmet.fide@screeningeagle.com
Subject: Re: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
Date: Thu, 29 Oct 2026 12:36:57 +0100
Message-ID: <20261029113657.2303346-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <54c3356a-5e19-4664-b189-904cc84b11e5@nabladev.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marek Vasut wrote:
> I assume that usbmisc driver could also be reused by VF610 , paging
> Mehmet on this topic.

Yes, it could. On Vybrid each controller has its own usbmisc
("fsl,vf610-usbmisc", usbmisc0 at 0x40034800, usbmisc1 at 0x400b4800,
index always 0). USBCx_CTRL has PWR_POL, OVER_CUR_POL and OVER_CUR_DIS
at bits 9, 8 and 7, the same as UCTRL on i.MX6, so the over-current and
power polarity code can be shared. ehci-vf sets OVER_CUR_POL and
OVER_CUR_DIS in that register directly today.

On the !DM_USB question: patch 3/9 of the ehci-vf v9 series removes the
!DM_USB path, so VF610 would only need the DM driver.

Once the driver is in, I can switch ehci-vf over to it and test it on
the Colibri VF50 and VF61.
