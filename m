Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77F8E83838
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1046683AAB;
	Mon, 16 Feb 2026 22:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="ehoP9rj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49F1D83AAB; Mon, 16 Feb 2026 22:30:53 +0100 (CET)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6EC80FA1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-1273349c56bso4549798c88.0
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 13:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1771277446; x=1771882246;
 darn=lists.denx.de; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3cT2jA7AE0dMZKoMnB7FBc7pTMpQfFFbJcaJ5/qZEfM=;
 b=ehoP9rj91ToHecbTrxm7xBE7Slvge2g4l9SBS9L+xWcFxAywCCst37xJpfzLH7szKp
 lW023gQo/RR2kIZyWw6yt3zaGlu1OnBzbiHoUEa6RjIW3BiYWkj6B1gSh2mMRQYJHwWu
 uLLecusj5XyObf1Iu+wC1l9Us+zZ+giCOsRRo7AvxHi/qY3Zz7WkKk/hTOGio3DbBEnP
 LYYgpdfyX2Pn4wevPkMAM5nP4wGW3GVKGyyYaHr62b99GqA45Qfngsytxok2cRFRxq0i
 pvBj+1lKGcdS85o57K36J2glzar0YS0INeQ9NrNwc9z29xXXFf1ZaDQ5+d+S7a3wPyvs
 fQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771277446; x=1771882246;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3cT2jA7AE0dMZKoMnB7FBc7pTMpQfFFbJcaJ5/qZEfM=;
 b=eoqvu5C6AbozZkucML4u+UdEu/8jJwWlNGPcsnuMAZAJnvo141yQgRuAfGV9EupdQ3
 /HJcEOT6kfH8QbzyKYdLI+c0rtVZ4b44WDmS+QSz7u2elvS3iR9ZYyqghQ0/OoqXNPLy
 BNpQ/P1QKs9lO4drYaDL965sPWq7gf3HPSiDUEi6P5l9c6eaxG78ILHLWYZaUAwu7lQq
 sXfT0WlC6VmIQgWM8jT/wHCXtg2I8nJLe9/RdpHSuTGCy6SeO6jejScmOzc7urSy3NUH
 6QZcOgy0z8ecm5O8HWKd8SlxhQgWvuTVbssMGuygppi+YylpYqIRIfDgrsenvWQM25UR
 AauQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI81ya+TrBxCXVcu3/3WLiz9g5VDYFHHI/DyWDcpi7vR5XjG8NGsuy6Y3opiRwtoifBGSAm3Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwQ2pFRrTVWboPkIBeIiYtEpRgdUoCcuRVsJwxPy9+u//82zG99
 yLfU0tTjQ81jMmYuaRvhO+hjwueWC5mD3dqlX4XMT6x0sWMVlIfeKGMflPEgbo44c1I=
X-Gm-Gg: AZuq6aJGEgvohKR+5pTnQU7n2ZFC4H9Q1Sr5KK3fZxtIHUmJGheHqLCquSBs59v99C2
 bRt6fezY1I8P7/vNaPFuggXmAir7EVw0jQaCO5utM043ll4wl4a0x8LQyUcPEqlCQbVDp4Xa62K
 6+SkmqNEJv7Oy/hxzvp1a5bY2XrWJg/WK1mTc4M30mMch8d9tsUtsV2iH8n2cdklLXpk68UTkQc
 kj0y0GxZXsMs0QJp7ZUiYRRlAbBoLrhpaSc2y19z+dmv3GJrROHeqHiA0s73XL+t+trAOsP3fJQ
 uJtClqcrsisGzBHLQuLVpkZ74USdTB5aPAdhAsGKDXrYDFdR42fDQJpL8+BeTlpmiGX4o0ALORk
 3RTZAQGg8Fr0BsEX/n21GWElFZZhDarBIG6mwF43EUU/nNQeucuGiig4e3EN4mp95L9OdweQ+Vo
 DsVxMm9iuq4uOn/ZfYuy+MsGGSSVutiTEYTe1uK85IZ6YmE7xBRqQN4Zt6
X-Received: by 2002:a05:7022:4582:b0:123:34e8:ae8e with SMTP id
 a92af1059eb24-12741c08f05mr4510615c88.50.1771277445709; 
 Mon, 16 Feb 2026 13:30:45 -0800 (PST)
Received: from smtpclient.apple ([2605:59c0:2082:bc08:cccd:6b2d:258:2d8c])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12742cc9376sm13157314c88.16.2026.02.16.13.30.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Feb 2026 13:30:45 -0800 (PST)
From: David Garske <david@wolfssl.com>
Message-Id: <CC9C4133-1AF8-4A32-8DEF-CBB716817422@wolfssl.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
Date: Mon, 16 Feb 2026 13:30:33 -0800
In-Reply-To: <20260212194620.GD2747538@bill-the-cat>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Todd Ouska <todd@wolfssl.com>,
 Larry Stefonic <larry@wolfssl.com>, Wolfram Kusterer <wolfram@wolfssl.com>,
 Aidan Garske <aidan@wolfssl.com>, Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
 <CANqXHyEShK3bCA-5K4K=zH_b19i9+o9DRPYW8LHo-gFpMB2Hkg@mail.gmail.com>
 <CANqXHyH3OwPEpo=rv6E+uSP01quOQisEJ3_aD2-r=DkNDK4_+g@mail.gmail.com>
 <CAC_iWjLKotX4X9mD1qnJbnkbh9xBHfnyF+b=b--XvMjjbCrU-g@mail.gmail.com>
 <CANqXHyGZSGybzchkqSE0-7s3HgfY=UBjpkjS1wjuRkZzOLDMWQ@mail.gmail.com>
 <430A021B-7511-4C08-B30C-72C153A25A27@wolfssl.com>
 <CALeDE9M7ENPccTD18b3YKrvYEu8yU0cXT1ePXM_tagV4Ou+Z0w@mail.gmail.com>
 <CAC_iWjKnbp_gtHQ6nMZEHEOx92NA2U1OLFKkgDtyqS_aDHO6GQ@mail.gmail.com>
 <48C4A401-E824-46BF-BC93-1EA9A45AC374@wolfssl.com>
 <CAC_iWjJD+_spstOX5z2tDoyEUZwbV7QXNz_s5ffz7FWK9QopEg@mail.gmail.com>
 <20260212194620.GD2747538@bill-the-cat>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:31:24 +0100
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

Can you confirm that the patch was received correctly? It appears it was =
based on the link Tom shared. Let me know if you have any feedback.

Thanks,
David Garske
Software Engineer, wolfSSL
+1 (530) 409-2990
https://www.wolfssl.com <https://www.wolfssl.com/>
https://github.com/wolfssl

> On Feb 12, 2026, at 11:46=E2=80=AFAM, Tom Rini <trini@konsulko.com> =
wrote:
>=20
> On Thu, Feb 12, 2026 at 02:58:19PM +0200, Ilias Apalodimas wrote:
>=20
>> Hi David,
>>=20
>> On Thu, 12 Feb 2026 at 04:11, David Garske <david@wolfssl.com> wrote:
>>>=20
>>> Hi Ilias,
>>>=20
>>> Thanks for your reply. I did submit the patch via git send-email on =
Jan 28 to u-boot@lists.denx.de with subject "[PATCH] tpm: Add wolfTPM =
library support for TPM 2.0=E2=80=9D. Can you check if you received it? =
Copy of the email is attached.
>>=20
>> I haven't and i can't find it on
>> https://lore.kernel.org/u-boot/?q=3DAdd+wolfTPM+ either. Any chance =
git
>> failed to send it?
>=20
> It's:
> =
https://lore.kernel.org/u-boot/20260128171112.1818705-1-david@wolfssl.com/=

>=20
> --=20
> Tom

