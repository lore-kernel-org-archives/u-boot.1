Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72381CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 20:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73664831D8;
	Mon, 11 Aug 2025 22:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SSsLEDRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9383831E0; Mon, 11 Aug 2025 22:52:58 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B3D831D5
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 22:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3e55b170787so1382985ab.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754945575; x=1755550375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FFK/nYtee7Fjg+MhdUWrYetKbWMZNZDhwfECKuAgHQ8=;
 b=SSsLEDRtgevMqKe0a0GJOB85pYKQwReQYLEOXZIjiSlQeoWEe6XszxHNQhuXgr+rIC
 blKMiBBamQvsprz21QFXIwa4XAr/+kJbec6MNbCSV6zmU2FLNN3t+ezPnrvNENFJyuT1
 yn2NITC5O92c85U9fMVlkAfrqwDCqDymmvIG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754945575; x=1755550375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFK/nYtee7Fjg+MhdUWrYetKbWMZNZDhwfECKuAgHQ8=;
 b=pU14KH38jlMwPW9RxGBqMpd4jW+hpK/44qcyuUM7B1fAUACVAjyMReZ1DoM/XuZ/RK
 z27u0EKwE2AJrC6Iz7WaNJ0SKecp0gY7WD1r9VNXyRgdVewcuPeuvNcUI5LfwewICQUs
 +HM2KXvXv0sMtEilhnnP4jf6i81HWDLb5Fu2RIIWzoTDQZ283YzhKxnc8aKfnYPOPqrM
 Hi0TJFQW/QlutMFu9Nd6belEyY/sGpJdGyyQq1njwIGIdsQ8HUzYStIicZ3cBLNMB22/
 kd00Y2b2bEyhBK0MLRLibR8dqfwUneQOS6qg4b1oYHkXnBu0f3Tyq8JM3GN85cYiWOwV
 urtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGjXsyzvu924DRSJijiLBedVKS5MtCv2d3AYBCggMVVuMYL/6GM25O/uutQWoWGG7insFVd08=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1lUiemKiDWfq7b6dUa4YG58Zf0tq/nN0WfX5QEgQPtz2dzAby
 q2BLDRESC14CkuAY7ti8yUy7w6DLKSsODEPT+9cMUrCHDne1M29p9Nb3hwJxbIeiDBM=
X-Gm-Gg: ASbGncsXfUecZo4JSrdo3irxyblw/M4XiC+DcwGT2B0gAyo477ybJlIM9babX0CytG3
 Wq1zgw5z9P1x+RQF0L6d5vV9qpl/CafQMv+hr+EVyedQBr1FLy+XAar/0+0joYJg3wBbqtNx3hy
 TBQIltHajVN+VoykE2472hzfY/8/z7a+w1o8H/Ib5BLdAAuNZei6z86s3swiZBemWSNJ9KZkiGd
 GRicweoFAyb5Ib2mvsR9XeS4xTRF9wQ33kCv+brtlmVnKP25tTsqFQTVPdj13Peefwt6KcBRtsg
 DnzUhM202RgE/ryMPRdLqRvlPs4/xkn2cv+02ncxJNFsUK3jxkDC3vs7ESFSBCK7RO5reRG9Yi+
 sLZ4DEBEorFAwFZ1r4o6GGlLD+qgHs2LqacncxSQaVgbD8H3xg2IVXJzC
X-Google-Smtp-Source: AGHT+IH71y27h1K6MHJw/9DbUbjN2eaJiQ9WXrGYvEgi+ixQKGXM/QcWnMaMaA1R5F8tBpk7xywtYA==
X-Received: by 2002:a05:6e02:16ca:b0:3e5:54d9:67b1 with SMTP id
 e9e14a558f8ab-3e55ac34dbfmr17599435ab.5.1754945575280; 
 Mon, 11 Aug 2025 13:52:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cc1bbesm40740615ab.28.2025.08.11.13.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 13:52:54 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:52:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 00/10] arm64: stack backtraces
Message-ID: <20250811205251.GA1643106@bill-the-cat>
References: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nTvis39/QhUdYXFo"
Content-Disposition: inline
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
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


--nTvis39/QhUdYXFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 06:07:21PM +0200, Casey Connolly wrote:

> Implement support for printing stack backtraces on ARM64, make
> framepointer support configurable by the build system with
> CONFIG_FRAMEPOINTER and teach U-Boot to walk the framepointers and
> unwind the stack when an exception occurs. Also show all 64 bits of the
> exception syndrom register (ESR).
>=20
> Additionally, a new global unwind_stack() function is added, this can
> be called from anywhere to print a backtrace which can be useful when
> debugging certain problems. It is now used during panic() when available
> to provide more useful information for debugging.
>=20
> A new printf format specifier is added: %pS will print a symbol name
> from an address, this is particularly useful for function pointers

This fails on sandbox because the prototype for unwind_stack is #if
guarded but usage is now if (IS_ENABLED(...)) guarded. The next problem
however is that the vsprintf.c changes aren't safe for non-ARM64:
lib/vsprintf.c: In function 'pointer':
lib/vsprintf.c:527:43: warning: cast from pointer to integer of different s=
ize [-Wpointer-to-int-cast]
  527 |                         return ptr_symbol((phys_addr_t)ptr, buf, en=
d,
      |                  =20

Handling for %S will need to be #if guarded I believe. Please push the
next iteration through CI, thanks.

--=20
Tom

--nTvis39/QhUdYXFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJpYIAAKCRAr4qD1Cr/k
CgOZAQC6A+LFVXRp7KkaI4hYS5uoi+uTXQVJMjAkP2FCmzjgHAD/abk/GjMT9HQi
rs1lGE81uRHjbueKYx87kKakkNC/gAE=
=xPB7
-----END PGP SIGNATURE-----

--nTvis39/QhUdYXFo--
