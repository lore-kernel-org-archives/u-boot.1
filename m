Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DC9E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 14:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD97583AC5;
	Wed, 18 Feb 2026 15:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cvkjoMpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3809A83D0F; Wed, 18 Feb 2026 15:21:11 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C5F83AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 15:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-65a40f3f048so8690291a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 06:21:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771424468; cv=none;
 d=google.com; s=arc-20240605;
 b=ItHdAzdi+kfJ/xaXaHSX/JwYzoQ9c7XG7rmb/nCVMzQv1j1ape9JhJ+Pr9/UV7MFjh
 kGAzGbJuWeDbyrBMGwsAppmZ5KrQXZxX/OZaRt0cALLxhmRbhzzqKQIr1odfBwvIkOsl
 PM5z5R98mZ41sgof4YxUKZS3XVGBJO4omvQzfthOgoDpteyv4XiN2BeIW/UuLl2YtpfI
 pDivuxlHyTtwoyDbBLuageif7IanxwK2S+uzfQVM6Z8H+8JNz+UHUASYpWuCrt/6YI7r
 AnGgDbhAQVAVBXjFo89Cia450rv1P7takQgcu+G6ng3OA0Yr1Fh7EY57U1I67hCvYwsa
 eEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QlWt4S3LieSg07FRbnR84wyOLF7qmRxJvcJmvftpJ4I=;
 fh=mxOgx5bqRtou26Q1Y2lPXACmdrWqGSsX4UELZgF5eHg=;
 b=UC0zeoXIVjbCF1cdl1gBHWTElwsarfEcEb5135ZTcAdJLDa2Km2YgzWSe0lnMBi83/
 D6MPZQ2sQjOWQvG76nvT2wLpXz9Uh2QGywxV7IQ1aiMllzqVZeLTkp9xh37JK8d5Wxrp
 pl0N/ktOkrpESBDUid3PCrJmlB3zpHoxXc010VpoleNvJ1CSuE1Tm8vA0bhUE33IzDup
 DslvUXxcwLRHGwu7c14r/bDuIKWzQog27vBxaVbk7CKvZ6beh9+2b3CLByAf7TZ1cAp9
 6jyKLn9lSod6SRXnN6ezrIrn0wZXuCF0ii11MIYeHqnaDsyaD00ND/bij8cw6OXlUOH6
 D/kw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771424468; x=1772029268; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlWt4S3LieSg07FRbnR84wyOLF7qmRxJvcJmvftpJ4I=;
 b=cvkjoMpuTNSIGdGFdq1X6PrM6mLjXkCQym6d4e1XgtuJB2p9SOgh+adlOA3xRWMa1E
 dUc1MOvZNp653eViKwtp6aMrz11maacDhn3f432X2S91LqC8vKAZpXlj2BZpOP2JCnXX
 MX21ZcltHjlibr9tEwMueJYcV6E+U1B4ZS38UmUxVlRFY3E/mzXbcWmLsiEKTWJceoAK
 42FzLsqZLNdr7vMy4bDQNkm80Yy4nFwCXAw8MxpFvqZ4lBQ2DEw2E/qxyXMdKJZSYp31
 9M1kb8Ymluqt5ED3Ud96sVvpaAQaNXMWh2KC5hK4r5pY/pckdHP6pWpSw3kHAHjuqQKv
 IWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771424468; x=1772029268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QlWt4S3LieSg07FRbnR84wyOLF7qmRxJvcJmvftpJ4I=;
 b=N1BH5af2Ppj4ILavu3V8n1gNPJm1MnuUxvF5+6xL4R+adjxon/a5Fh3Nhqr/XT4k34
 E7u/Ha6RQnIj9amU4dN04udfq7YmfUbPmoSghFZWD82dlV6euunM9IrrthY+ktAmQIIv
 QA8e6tCpi6Fi9ElK+BWKl2OUsNpB3cwj7uMKAcYBFbHcC15rQHH9xQANe01lA8pGQCm1
 1rjhOokH9+JEaDjQWkc8jeB2rVCSQxUG2QA+NbUXe8p32tKi3cQm6FI1wioIJgg1f0/I
 b/wDFD97J0MMR6kI4Ns8CHXoYMq5J+UbRNAfTTq28bqF7Q/2Oneu2zyvy9GmiW1nyI5g
 AiyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW7WTjTLkNLR2JsfT2qVj9mpJNW3pFefblE80/Ha9KxJvxZU9DP8dBwO4X5D+kyNWQWLG2Fyc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf2xMGfMkq/o5cviJ9brHTP+3G3dzXGeMCXQgufPd3qPNAsUTg
 LNgWnrvuMA8wk2ZKc6Gn4R0tpzzeKRXIr2ZpcFi920cy73IoGcY0ZRCwELWW13wtP5fLq95RFR1
 R+UaUHAsQyCdhkz/WjCd9yAIkPWF4rUg=
X-Gm-Gg: AZuq6aKXcicYL9kvyCKQrGxN4PASPf/kSbTptgq24A1H19LMnwnAFfonyx4vmPOiohj
 1LyhDOXhM5SI/1sS+Ech2vTAYUXyslKN8BiMuOg1p7H340RT1BWEKMN4MZV97QzmHMSyEe4LhOd
 ny+/LnbP/X5JAgqP+jQIkpZThxwitywsctvWr05vZWd9O7OUXthfx6Pho2Ifiaz1VerLAWcAsfX
 MGaaYprkz3rsBKbvesqFPGxg98Um0pfbAEZ/u9eJEd37I9HSLXJqxcGbsbY6BKTVOh+ZcIkr8qf
 hwsAAIHa0yrDC3kkVXvJSik7gM0q5TGzD8an451mlQHjmUdbHHPdwoC5dabyWDyzZWEQm3loHRx
 oQyxhGlcqgyLlJ9t6WNIOQYZjpbJq9dGqeuT7TlEVARhXy3Eo
X-Received: by 2002:a05:6402:34d3:b0:659:46ee:aa18 with SMTP id
 4fb4d7f45d1cf-65c766dcb70mr1368684a12.0.1771424468337; Wed, 18 Feb 2026
 06:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20260213164607.GI2747538@bill-the-cat>
 <20260214-sternness-cling-4259916a8f73@spud>
 <DGG8OA1O1UEL.12RR559TX4XX6@kernel.org>
 <20260216153110.GV2747538@bill-the-cat>
 <87bjhmv20f.fsf@bootlin.com>
In-Reply-To: <87bjhmv20f.fsf@bootlin.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 18 Feb 2026 14:20:56 +0000
X-Gm-Features: AaiRm50hCwa57j8ojjUZKhCse5VY01sPPW_fKc-sEdekbv6lv6Nro1iIQHC5sSc
Message-ID: <CALeDE9OiivzK9-Hy6RN0yD5ctiBRVC_GtHXvmnXRzx5-e-NV5w@mail.gmail.com>
Subject: Re: [RFH] SPI and SPI-NOR patch help
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Michael Walle <mwalle@kernel.org>, 
 Conor Dooley <conor@kernel.org>, u-boot@lists.denx.de, 
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 18 Feb 2026 at 13:40, Miquel Raynal <miquel.raynal@bootlin.com> wro=
te:
>
> Hello Tom,
>
> On 16/02/2026 at 09:31:10 -06, Tom Rini <trini@konsulko.com> wrote:
>
> > On Mon, Feb 16, 2026 at 09:21:55AM +0100, Michael Walle wrote:
> >> On Sat Feb 14, 2026 at 7:58 PM CET, Conor Dooley wrote:
> >> > On Fri, Feb 13, 2026 at 10:46:07AM -0600, Tom Rini wrote:
> >> >> Hey all,
> >> >>
> >> >> To be blunt, U-Boot needs help with reviewing and maintaining the S=
PI
> >> >> and SPI-NOR subsystems. We haven't had someone with time to activel=
y
> >> >> work in this area for some time. I'm going through the outstanding
> >> >> changes now, but it also seems a common problem is that with respec=
t to
> >> >> device IDs, most of the new ones also aren't in the upstream Linux
> >> >> Kernel. Is there some better and generic solution we're missing so =
that
> >> >> we don't have large and often growing device ID tables? I'd rather =
not
> >> >> make that problem worse, so I've rejected two of those types of upd=
ates
> >> >> today and I'm just setting aside a large number of others.
> >> >
> >> > Dunno if your timing was cursed on sending this, but Tudor submitted=
 his
> >> > resignation from spi-nor maintainership in the kernel about 10 mins
> >> > after.
> >> > I think Michael Walle might be responsible for what you're talking a=
bout
> >> > here, with his 773bbe1044973 ("mtd: spi-nor: add generic flash drive=
r"),
> >> > but idk jack about spi-nor stuff.
> >>
> >> Yeah. Nowadays SPI-NOR flashes come with self describing tables,
> >> which are already supported by u-boot, I think. The only change that
> >> seems to be missing is the fallback to it if an id isn't found in
> >> the flashdb. Only thing is, the SFDP doesn't describe all features,
> >> most prominent example being locking. So if you need that, you'll
> >> still need to have an entry per flash.
> >>
> >> In fact, in linux I'm planning to change to make it probe SFDP first
> >> and then amend it with the flashdb information (if there is an
> >> entry).
> >
> > Thanks for explaining. So in that U-Boot does have SFDP support, the
> > first thing is platforms should likely be enabling that instead of just
> > adding IDs, at least for basic support.
>
> Yes. There will be the need for IDs anyways, for those "extra" "non
> sfdp" features, but that should reduce the load. For example, shall we
> consider block protection in U-Boot or not? This is a useful feature,
> but at the same time, do we really need it in a Bootloader? This is open
> to discussion.

By block protection do you mean for features like rpmc counters for
rollback protection? If so I suspect there's some usefulness to
supporting it given U-Boot ends up being the entry point for FW stack
updates using mechanisms like UEFI capsule support.

> > It still leaves us in a bad spot
> > about having SPI and SPI-NOR stuff reviewed and maintained, but at leas=
t
> > it's clearer in public now where it stands.
>
> I guess spi-mem and SPI NAND is also in this kind of situation, even
> with the Amarula crew doing what they can to improve the situation.
>
> Thanks,
> Miqu=C3=A8l
