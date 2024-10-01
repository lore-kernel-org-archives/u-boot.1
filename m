Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B6CCEACF8
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB0358927B;
	Tue,  1 Oct 2024 20:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ms7aQpnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E847A8929D; Tue,  1 Oct 2024 20:44:33 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9953889279
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a9aa913442so554601785a.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 11:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727808270; x=1728413070; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MGZZ1QhWcnNLHiSBr+stXhNsnho7qLzAWLBYFPK47DA=;
 b=ms7aQpnqx7qxXh7HLg/4R3ZyIvZWp1uc3s6S3VD878s4zZYXNj5cP2gomA27KgTgou
 ckaJopeDkxy2y0/M/WsIWhim8ujdqwNa/ay7v2VFtHL3wwSa+AqzdgwqhtzeTnFK50bz
 Dki3Z0dbiN20LDgJ7YVZdGVAhNhaQeAWYEpaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727808270; x=1728413070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGZZ1QhWcnNLHiSBr+stXhNsnho7qLzAWLBYFPK47DA=;
 b=w052+s4bjCEF//6Xj7wIS9iGj5DH3zhiio9YKHd3qI3dXT53RDBl2NB77FvVNfHIJk
 M1Y2NZl6UEVDlrRdHi08Y6nr+JQZyK0GwU4QfgKm0AJoLBH2e3wAu5IZapK/MQApmYkW
 VfxqiqQFTLFzS78h71vi0N5u9JHdlmSwiByipZFhsd+Cq1G4i5vDuw2ZhzHBPqPIgbhQ
 ykPTzaUADs7qMYg9Cbnc95Bu4Yezc/KndJ8uN9+Ja2oUCmv3MQE+TtQIuP2XBqkETKb5
 mK9rA1QiNtr+JtdsPbc1+NT8tmWZZaW6sIAvDs7Un26bUIhhEbQWwAKhohNXysbj7k+l
 Rkpw==
X-Gm-Message-State: AOJu0YyMPWy4b8G+x+X70V9TmS7cjP6SALNufkpKLCus9KeJ/moJy+cG
 DDWENMR/E48LtyE4QnILQbEKfoiIaN/kmhcW7a6g2rEH3f7f2UObq895PK7+gzc=
X-Google-Smtp-Source: AGHT+IEdpw5wsJj4l4JsTiNEfeypOf9axsNMYH3LQuVKIrwmu8nHrbOFnG4qkxoQcX6yk9Bvn9c1gg==
X-Received: by 2002:a05:6214:5503:b0:6cb:50c8:b5f7 with SMTP id
 6a1803df08f44-6cb81dd8f44mr4423636d6.52.1727808270314; 
 Tue, 01 Oct 2024 11:44:30 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b681749sm52668406d6.123.2024.10.01.11.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 11:44:29 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:44:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240930
Message-ID: <20241001184426.GI4737@bill-the-cat>
References: <87h69xmaaz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cUogWMtEkOx2ZMVF"
Content-Disposition: inline
In-Reply-To: <87h69xmaaz.fsf@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--cUogWMtEkOx2ZMVF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 05:27:16PM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some fixes for master:
> - Fix Kconfig dependencies for DFU_OVER_USB
>=20
> CI job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22468/
>=20
> PS: I know it's a bit late, if you'd prefer to defer this to next
> release, let me know.
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 5f044932413694475422d4b16607dfcf9aff87=
81:
>=20
>   scripts/Makefile.lib: do not include CONFIG_DEVICE_TREE_INCLUDES in dts=
i_include_list (2024-09-10 11:31:54 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240930
>=20
> for you to fetch changes up to 2f9c472dd7a91bc2d6e7840a550edcd257ff8b57:
>=20
>   dfu: fix Kconfig dependencies (2024-09-13 17:41:18 +0200)
>=20

For the record, I applied this prior to v2024.10-rc6 but seemed to
forget the email, sorry.

--=20
Tom

--cUogWMtEkOx2ZMVF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb8QwcACgkQFHw5/5Y0
tyyR/wwAhTIr3FQ+945CDVKBhNYTOlr1Hk/7au8qOEYXBWYZef2fkjaXaHYstTEj
P952AQ8SBkjV1vMmVZBN3ligYRGWpWTE7RqwJn9WEp7jlyMybViCUQUrClYVmfRa
PdtmuYt6CNnmjEv0M0P+02ZCAl1h2i/JPyTWfeIT7ZGH1l6BEuhAC0JVW4RFtXsD
DW+6fZrf4dPNv6263F7XwAzyQ8HXDhDjNytMiAPYINUYTtRlj7IJPTakL5CT1Pmd
MZIsWorJ1gvJirfq4baQjReDVo5RVIMkKOyaz2ImOJCsnATglxWpwernn9/3oZhi
yuphijf/h45q6BQZeS6TtNGZqc8Xky/WRVRMG9aWyqf9Pwdoid/fkxQ+X1q5lAD1
0iUR+xBJFGyK1s3HjmhcMQc0j7cymA0QmgNcFRHhjkH9j3wo+iwSfovEpN1kwIeB
mpxar6GNElC1drM43IIwpZsP9aL8EvhMzs6jUhLa4vyRrUqm/p5LUL4LbU90sPFn
vC6cPnmI
=HYrs
-----END PGP SIGNATURE-----

--cUogWMtEkOx2ZMVF--
