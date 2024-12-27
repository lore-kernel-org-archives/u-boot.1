Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3810E7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 21:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8AB48036E;
	Fri, 27 Dec 2024 22:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oJGntklO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A92480422; Fri, 27 Dec 2024 22:00:20 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF05A8021A
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 22:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b9c6c2c44eso405668085a.1
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 13:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735333217; x=1735938017; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EfwBVXyCHdrRDhtjRsV+Hd51pyBg7VzTU/V9pUTwLP0=;
 b=oJGntklOAMYietgxDGuv3tW1EIU5mkhKq14PoT8pt2ta1UsFKDZ8NrV+5NKvLoTR2P
 3xdoC6KRab4D+hWZTMqcwlE20W8vEAdsQkNO8DcVkiklmqQcowXhRDRfJBO68rU7l2JX
 LZTOAgYoX7nvp5/Ef6a+CUMBy3pCLEhWYeoAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735333217; x=1735938017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfwBVXyCHdrRDhtjRsV+Hd51pyBg7VzTU/V9pUTwLP0=;
 b=cYgPyPwxUlWSS2ew6hWwLalRYW8jHjv/W3JFTEObNmTWYCNY42uL3atKVcdw8LDQZv
 AAmQNRNE8XL2cP2chwP3HvHYcWB2knqJyyJAZVuRZqtrX4geRyRoAqy7CB1E5DtCzL8Y
 7Ed8PMjHMifx/hkP+5qUVAwJz3bkeeRCHpxixOpo0Q/SZWGQVVTGlX4Wec01Vli0ZkC1
 z8vJmCqJ4+wDIF4HTCfd7u7wZW7KAH3IABNxmBjPkg1rE2IU+rmVJ4kpKKg06AB7YTRW
 78rspmxY87Mife7mQAySV44nLljaXpMXSXVx8bG3vorrP6F9EhCskdm07USyVLS0v6G2
 ZI6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq8op7+1/xIfnMjZztXmMQPEAymBYXw2uuLJNZ7w/tsnR+NmqTSQhmMZhu0Bu+cr43KvZ2kMA=@lists.denx.de
X-Gm-Message-State: AOJu0YyNQaKGEar7Iff5h+LwTxcOcin1w2BjgtKgBxh7g8bHMXuKj5iF
 uWZdZEp/SmrBU4p41NQFOuWmPxSMm7UWIxewtwm3vhlQnVRVtOQLWJubvr3q2ys=
X-Gm-Gg: ASbGncukyXRT18NqXIQFDuJwBinFtcS2D5g5t/pRSBy0XyCbLFZVIlKxI7xYAt40lI5
 YigS5dLo06CZsfQlDOGEpqCORD2265DDt0Z1+6mokpW8szaO/ruwAgAmSMO0EAVVj2D5KfxYeRn
 8h58yY7RCwkNGHpKlzkMFg2ESRFE9fS7r8aJZE2VaHdUmcE+QjeAwbo9nTM0jMxAmOlEUcPTz8n
 PnXCfXGhrW/84azY/RhBqhH+i66VWEciv6S7KCzVoVDQjURcbGPHSWtxg==
X-Google-Smtp-Source: AGHT+IFPIhEMh2AzEV9rySbq60stckNTAh4qmLNgoTT3t2QxHxoSZOKcnfkJ3kRmyYHZchspjuV5CA==
X-Received: by 2002:a05:620a:84c7:b0:7b6:c92e:2e6d with SMTP id
 af79cd13be357-7b9ba810c11mr4942353985a.52.1735333216764; 
 Fri, 27 Dec 2024 13:00:16 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2bc3aasm725482485a.26.2024.12.27.13.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 13:00:16 -0800 (PST)
Date: Fri, 27 Dec 2024 15:00:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v15 00/11] net: tcp: improve tcp support in legacy stack
Message-ID: <20241227210012.GG1505244@bill-the-cat>
References: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eIRMf/P8DnrqyTVr"
Content-Disposition: inline
In-Reply-To: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
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


--eIRMf/P8DnrqyTVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 01:58:41PM +0300, Mikhail Kshevetskiy wrote:

> Legacy TCP stack is bad. Here are some of the known issues:
>  * tcp packet from other connection can break a current one
>  * tcp send sequence always starts from zero
>  * bad tcp options processing
>  * strange assumptions on packet size for selective acknowledge
>  * tcp interface assumes one of the two scenarios:
>      - data downloading from remote host to a board
>      - request-response exchange with a small packets
>    so it's not possible to upload large amount of data from the
>    board to remote host.
>  * wget test generate bad tcp stream, test should fail but it passes inst=
ead
>=20
> This series of patches fixes all of the above issues.
>=20
> The benefits:
>  * A lot of bug was fixed
>  * Better and more reliable TCP state machine
>  * Tcp clients becomes smaller/simpler
>  * Data uploading was fixed (now it's possible to transmit a huge amount =
of
>    data from the board to remote host)
>=20
> Modification was verified with
>  * firmware downloading via u-boot wget command
>  * fastboot over tcp
>  * netcat linux client using test netcat implementation (not included
>    to this patch series)
>  * Firefox/Chrome/Edge using test web-server implementation (not included
>    to this patch series)

This fails on the EFI self test on qemu-arm64. You can see this with
"bootefi selftest" on the platform, and the excerpt from the full
failure log at:
https://source.denx.de/u-boot/u-boot/-/jobs/984858
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10224&view=3Dl=
ogs&s=3D664d8594-b731-54d7-afc5-7167226e08f3&j=3D52970d71-9fb7-5005-2ae1-66=
817be903ba
is:
Setting up 'http protocol' succeeded
Executing 'http protocol'
93.184.215.14
Packets received 5, Transfer Successful
lib/efi_selftest/efi_selftest_http.c(216):
ERROR: File not found
lib/efi_selftest/efi_selftest.c(114):
ERROR: Executing 'http protocol' failed
Tearing down 'http protocol'

--=20
Tom

--eIRMf/P8DnrqyTVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdvFVkACgkQFHw5/5Y0
tywrEwv/Rm62MGpu1aa0nFE3qpEQghWznWOjWo4DRiEovj2Bil9l/fw8Brir1u7G
iMrwIaYaCc96YmH8SHENKPlctwDJ0FNmdnmesGlj/WgKcdoy8C9TnCfatErwJ05D
J59aUc/rYaioUi7QtPCU7yfKB5JkPb3uIZtiez4qEKgJ38fPNl1peENXel5bw0aw
yY4o1lg19nHnarpk+MZ8UvoHIKVo+gcs8YwIXXhMJxHf5T/7Fff2/z3avFU3y2/7
1tJbhkACwp+KV7w+6dNDOHKC4pLQCCaewPe+Qwb9y3nkz0h+WG56rpUZyHO6Z9sW
cM9VQ6PIrn+2ES0oP9OQeoLeKHtfV9H3+xCqZ2REwi93Pdt3YocK7O2K0WrvRiH0
SLP+qoRCDWG+7Nd2Mv+K0xybG4suY5v0j3dLv893zDXrDrsP+JFUVVsRhQ4LXQeW
+gut46sNyDdBPkTN1SZoSRs7vuxIjNyzQH2FhKIsCyD1Vx1VYNQ0LedMpcE89DHi
rE09BOOY
=JULP
-----END PGP SIGNATURE-----

--eIRMf/P8DnrqyTVr--
