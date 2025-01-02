Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A28E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 16:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6AB8007D;
	Thu,  2 Jan 2025 17:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qsmgvZtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9780580196; Thu,  2 Jan 2025 17:53:10 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CDA28001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 17:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6dd0d09215aso93107846d6.2
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 08:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735836787; x=1736441587; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zoI8pG3/C82nnxD/U9ZOrCP4koBzio5qgHYh8DQSQxY=;
 b=qsmgvZtRUCIakwtalYZX9jiXibAwJh6yZ0m7cVlc2s1q/zXbKp8Es7roxBXQHzU3S5
 kx5fRusbp2i/ZcCKnBKCbki3Lcv6npzzAURpBnDS9kr8bhK6IQUqkgmuyHqPOmV2X5Jr
 EAilREF3CAw0DDN3yM0yB3mGS/TS/td+e1wm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735836787; x=1736441587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoI8pG3/C82nnxD/U9ZOrCP4koBzio5qgHYh8DQSQxY=;
 b=rYJgT13PGwdo9sFPudnJcYlOttbwHo7jNfOsdVAqwIL6vfyoEu3V9gTMeIfnLO5bEr
 8Pe/pVfGAPZK0NT3c/UM6LeFS6hIP/BGL0ofIfLRcy5WwznyDfoAIyJU6B7QU7RuXqyT
 Og1SAKFY3UkMzGRo2lwc1xB5CiHrfWz4/gYYgm9qsk2EnWRatb62mOOShz3Al/a1Gr5a
 nycTs+kuXQhh9oGAy5Fwsb48X+mSjGcJ7eTw+S+IpGaChjGMLeXREbWhj24Bpmo/c9Im
 S4Xx7YyS58o6SqEK0LvYb3aQkU8FjIDx5SHJEa/MIJqQtgGy7gEW22IYvxAdBcgFlh77
 FE3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd97d3oy1B/cl0BP9FGlI/SKYZj3mpqdhuqf+xE3kbz/qwZXP8n9/oI+LCLdubSXoc6H6iaRg=@lists.denx.de
X-Gm-Message-State: AOJu0YzpWoJAhV+wdvA28yVcMoSEPdGiKhQ7w3ICybNZGbFmf3AiZy41
 E5m3Ri8IPlbeWuo8jqA2rKayRcQ4unxpx0DQfzDMbxDn+Feg7ibZEcgT/sg7SXE=
X-Gm-Gg: ASbGncvs4Eeb/tZ0qvqgC7GMjHBwB7Gbw2qMVaQuTQhlt1gzjey5W81S1msJSpCqSzC
 rtfNplMeMU8ajVhKrtmtR2xCIPu9Sscn6EE5v8lsOjJE6Y7/rPNhyPYg/xZoVjZHgKv7M1OEOmC
 TJOzuGRTD4y4RrRTLbcwtNjjJe1617oH2j9tONeXekg6X9Q4i5VOKTzW6wTmJLZ/6/S7v+HY/LZ
 VXo40ANOX6s50FrCjuwNikqI3+SbDKAPSqSsOkXXaFG0O+NBaaH0o9tdQ==
X-Google-Smtp-Source: AGHT+IGl/P23B4RiHTk82SkO73NppeLkS/9rlAaOYaWr5tJZNM/XY5OFnTVkwmsyfclCbshcJrtSOQ==
X-Received: by 2002:a05:6214:5018:b0:6d8:8a8f:75b0 with SMTP id
 6a1803df08f44-6dd23344ca6mr766349286d6.14.1735836786670; 
 Thu, 02 Jan 2025 08:53:06 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd598e8f26sm79489086d6.119.2025.01.02.08.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 08:53:05 -0800 (PST)
Date: Thu, 2 Jan 2025 10:53:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
Message-ID: <20250102165302.GQ3476@bill-the-cat>
References: <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
 <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
 <20241216183014.GH1505244@bill-the-cat>
 <CAFLszTg3YgBABRqFOmzaz5KT1ipqmuFxTd1NX1x2yQz2rNgjZw@mail.gmail.com>
 <CAEfUkUJsdH=YjcN4V8Fe8Vfa2Sdb4PQJZxKe6y9RaRXcJgX_=Q@mail.gmail.com>
 <20241219163604.GV1505244@bill-the-cat>
 <CAFLszThG6SY-BvZQ_FzZ+AT+w0NSVmS_iS+nvCWaqoxVRvv6dg@mail.gmail.com>
 <CAEfUkUJhuCB-5dXt1+FKMAk1t_N_sO6qAZHMK5NJrV7coGH6MA@mail.gmail.com>
 <20250102154844.GO3476@bill-the-cat>
 <CAEfUkUJvm-Co4sZLbJEXTey3HPjTdEs33HBZzSY0BrVcMi=rYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YTW5g8mQUvMxQUpl"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJvm-Co4sZLbJEXTey3HPjTdEs33HBZzSY0BrVcMi=rYA@mail.gmail.com>
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


--YTW5g8mQUvMxQUpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2025 at 11:00:02AM -0500, Raymond Mao wrote:
> Hi Tom,
>=20
> On Thu, 2 Jan 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Thu, Jan 02, 2025 at 10:25:15AM -0500, Raymond Mao wrote:
> >
> > [snip]
> > > As I said, we need an kconfig here to decide whether a user should lo=
ok
> > for
> > > TPM log (and all other handoff information defined by the Firmware
> > Handoff
> > > specification) from the bloblist or not.
> > > We don't have such kconfig now.
> >
> > We do we need this knob? I don't think that we do. The case of bloblist
> > not existing where we looked for it needs to work. And the case of the
> > bloblist not having an entry needs to work (or if it *must* exist,
> > that's a separate option to add, ie CONFIG_TPM_BLOBLIST_LOG_REQUIRED).
> >
> I think this kconfig should not be only for TPM log, but for all general
> blob tags which are required to be handed over.
> User should have a choice to hand over *all* required handoff data from a
> blobllist (if exists) or to stay in each data's own legacy way (from DT or
> whatever)
> Aka, the switch should be general and "one for all", otherwise, we have to
> add multiple CONFIG_XXX_BLOBLIST_REQUIRED in the future.

Since we're just getting this effort really moving forward now, I'd
like to go with the assumption that bloblists will be complete if
passed. So if the TPM code wants to do:
if (IS_ENABLED(CONFIG_BLOBLIST))
  ... no event log found ... hang("No eventlog in bloblist!") ...
That's fine and how we can enforce requirements. But we don't know for
certain what a previous to U-Boot stage will or will not have done. It
could be TF-A, it could be U-Boot, it could be something else. We also
don't have a list of strictly required tags, so that too is perhaps part
of the problem.

--=20
Tom

--YTW5g8mQUvMxQUpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd2xGsACgkQFHw5/5Y0
tyxB3wwAn+Hor/yxyWzJ0TuIV0tMTkZv3He1RRVn5q+wLJpHmXOyk4pnI8RgpBhm
gKun5k46S1cwnYHgkaIh5FArgzwBqgUHAGEZVjoJxHf4wYLkUo84HjvhIO21X7Eu
wpI0ABeXiqkiHxqgTx3lowy5TOJ7S3/2baQWR+oMt4GgjYw28MikpvZ7nxt5FNfY
zpG19jWrLToAPEA3jCk3mqFmBoD6H6ayAt2Rhv0kOObkxSey6I5De1kyASZPgREm
ogynEr5RHgEycPKNm1sDH3ZXQSgp/0lv9MPAE1YsRmKzCXP2mlsC17SYaUrWQ7TX
XD/T2DUy5xQIYZSinbY7NXIlSUELg2tGTkTY09ktlGKKphZ5nUjoMEdqXL8czREU
1NJXq+ZhXXjvXUdtgREAAQhoRJnKp4rRYYAEVAIAbl33cZ8Frzkls7Tz6fu+/pmm
yXg3tvYKGIszPVb8ph7OsGQEaw0QKKuMpeUUrsGqINlOu2cUE4Ozg58/h4uA6A2C
dDx6G5qf
=PYNk
-----END PGP SIGNATURE-----

--YTW5g8mQUvMxQUpl--
