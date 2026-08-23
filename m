Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9C0C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 18:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E46614055C;
	Sun, 23 Aug 2026 18:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cZq--MOfCrtf; Sun, 23 Aug 2026 18:59:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787511575;
	bh=DAHGgmPtf7aizNU9kRLPOXMA7l7n2UocZv6es3HnpmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K7cN2yXnwGFb5KQBlhFL4+SxkxNHVRHGbZz94nrhy4gQfnAgBvigU0l2rKGhC2U2W
	 R87IHTfy73yqIPY7oF3prDTFDurVV8upvbJcw1ZNwnH3JCjtDSv8K90hvg7lQnQ1Mf
	 fbdjXRqIz7ZmycLE8Q3QIwLe7LTRBHDt0fiXRw0gufKlx2FW8ykm73VD2AX4Kb43Wj
	 fHhXKnrZKaTEpZ/dNQCmsq0gUZAwb3VkWY94C7BbZvnXwLwzMl67Tpn8wKma3qq+hm
	 LC26c0Qfoqk6dohNrILj7guaZNYX4RLzRXLT6h0wYED9ltGmLuaLm+SRJjABmZJPhV
	 F5uMiDh5G+fnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C3B9404DE;
	Sun, 23 Aug 2026 18:59:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 593443DA
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 18:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B6E940059
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 18:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 218uG9vtLdS8 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 18:59:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=g5wPheuJ
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 651B840057
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 18:59:32 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-4483c9986ceso1450956fac.0
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787511571; x=1788116371;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DAHGgmPtf7aizNU9kRLPOXMA7l7n2UocZv6es3HnpmI=;
 b=g5wPheuJoL/UqmbZtI7jf5jZtAtUc0uHCBsryIuxsV8UtAzsjRY2GfD1ic4/5tB/p1
 rtL+yjTuO7Pk+emBvaGwbY8+dPzYZbtTouwue67jeQJyF1+lMAYmKFKBFq4J0xP3JjU+
 VD61RrJN0D1G9xllB2TQOv4Wt8eEqoFqmwm38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787511571; x=1788116371;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DAHGgmPtf7aizNU9kRLPOXMA7l7n2UocZv6es3HnpmI=;
 b=EHCyKdCcOOOmRzh4j6tf26DZb1zvO0+FYMAWaDZL+Jt38BgaaQzQTQzDfDeYJ+Eb5y
 tm5DvTMtBbSgpcc2MUGvpNHMfssU116wNgjKIsv7ywSloIHmJJ12WZ88fs49cfdEhVhm
 tZtMSk0/IBf6trggSuy58AoPIKpBeRhKrEBUNEUFYlpCk0IakC3ASUuPxLEzUT9NOSqQ
 XkufxwNdRsdCCmp9ALHQk/ODTyqxNBdKa1k2LYE4jcQfTTVdya1YnrR653sJmcyCmfzG
 GPKOJ36cbxfmiUw5TDkA1emon4u7zbio2E+5+6WwBCKIHe2NP+/IAixRN7bqOT8SWZdP
 zwGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RowtDQTF4DQDxLjSv+bmBWReLxaV8GDNGmCeR/ZNhAKYBjkx6RD4km3LZ/UUWhIXdjOOM94mXY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n/4GlwSGh0NFmNoUyYS5x1fJKBsp4lm4GXGrKmIMyixOzXIRfr
 Mm8S0BCpySmjw40ioHLyGYDCnYF0fjrNV0v8WLVL4lmq78Gu544GwweG+6hT4e5G2mg=
X-Gm-Gg: AR+sD10DhRCx1EDAuwHqXshrLKmfP3ZgPPqtCGsAq4gyfOpyYfVNO+5q+j6e2XOoH3l
 7Ui02qp+dWgQm5qWBghW52GjL2QoSPVv6Nfo2DrVi00IavsCBUz2EIGn4QThtU8yqhjXryz9WX3
 X6MiQ9GD2kY7G9ARVtF3ghG7vI2EFpNVrn43oCVlabrLAT1gb1Qz/lLtKOr4boYzksNklte0lwC
 XNi0s+5fCG60Yn6tUUcBtsgz7BAiWxz9snIkausDCd11Ct72wzYZ4uGgZbX36I7Ms3QT0buYNR8
 4IQRvMJGIYzOMjtKtHY6PnllDuMYWFRTNXpWs39lzTo9dyQx1F7aAiVCepeM8enj/2fGCCxLILQ
 4qtPnlBk6vOwHSvmVDWH6td6u6hXQhvENsUzB0EvVHVCYPj/nmhm7Syq69EM9qXZh5Az6eqB7W1
 1T4f3T0mDN9YY3Bky8HutSP24AjEqQXHtdYoSkgAQlkSTK0DpTKF9vwd2hqP3+7jQRPXS8Cgm1T
 FNjpXqpo4JgBvzUkdWqCoVA8K6Od0JFALPNd9TywVOagBPD8Dp4DoZRJjppfly4JRj0cXEmNfjg
 yxBP8ttkYw==
X-Received: by 2002:a05:6870:830c:b0:456:cd41:1492 with SMTP id
 586e51a60fabf-463519fa285mr16573267fac.1.1787511571639; 
 Sun, 23 Aug 2026 11:59:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-463835a6b93sm3914215fac.17.2026.08.23.11.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 11:59:30 -0700 (PDT)
Date: Sun, 23 Aug 2026 12:59:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, mkorpershoek@kernel.org,
 ilias.apalodimas@linaro.org, michal.simek@amd.com,
 alchark@flipper.net, jerome.forissier@arm.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 01/87] usb: host: re-import xhci-ext-caps.h from
 kernel v6.16
Message-ID: <20260823185928.GB523975@bill-the-cat>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
 <20260821084829.2070426-2-anders.roxell@linaro.org>
 <20260821194451.GA3890585@bill-the-cat>
 <a4ff5d24-9da3-44ad-934c-8a8b0caaad42@mailbox.org>
 <CADYN=9KBebUKhgwkvZ__EO8vjktsP+-cA=FuryObWpn5eGpysg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I10HGJOlneuiW3Ek"
Content-Disposition: inline
In-Reply-To: <CADYN=9KBebUKhgwkvZ__EO8vjktsP+-cA=FuryObWpn5eGpysg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--I10HGJOlneuiW3Ek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 08:44:33PM +0200, Anders Roxell wrote:

> Hi Marek, Tom,
>=20
> I'm sorry, my send died in the middle, gmail locked me out, so the
> cover letter and the last patches never went out. Marek, the tree
> is at https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v6.
> Tom, yes to the split: 01-63 import, 64-87 make it work. The import
> patches are unchanged since v5. I will fix the cc list for v7.

If the import patches are unchanged since v5, I think maybe we can just
say v7 onward is only the second half? Marek, does that work for you as
well? b4 can be told to grab a specific version and numbers of patches.

--=20
Tom

--I10HGJOlneuiW3Ek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaotDDAAKCRAr4qD1Cr/k
CiJmAP9Ia9bQjRB0HicryU8mxvsc/j6j//0xrK8JqNd+sSMqCwD9GGG3LGOMSDA5
CwKunSomDfd9BhTqEj3nqhSgkqLhpAw=
=k76I
-----END PGP SIGNATURE-----

--I10HGJOlneuiW3Ek--
