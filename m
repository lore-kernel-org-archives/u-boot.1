Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F22CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 14:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F5881D6A;
	Tue, 30 Sep 2025 16:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X1uvuwar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29AF483335; Tue, 30 Sep 2025 16:59:27 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50103802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-4256f499013so30222605ab.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759244363; x=1759849163; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k4nd0FCQuP+Td4AfwceDzCnyIUVdJxmcP1X8TiXzKDw=;
 b=X1uvuwarTZgNKuzkZYuqxXWy+pM3Kyk8AdeY+rQLIHs2accp1g2uhcfMGceIP7kCP/
 0AUMktpVCHcpblavSOW6lrLSo5X+HDMeIe3oD+ybDoXFoIWF/Mv/1V7V7mkbB5zAEwS7
 VLj6SVVNfaDiO8QmbxxOOf6ROBUw28Z38ABAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759244363; x=1759849163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4nd0FCQuP+Td4AfwceDzCnyIUVdJxmcP1X8TiXzKDw=;
 b=pqEwkxiY92zodVqar2iqOXsUJhYcv/uGVPFB/+c15YEHNjbIOP/06iho14XsgHdjUm
 CxTuc9IPJji+/rbuQkkYn6yNHjDUg/aUR7h0mTgV0oDDlh1KgoZ0iu+W9bWKW1r5pa2b
 4D5N7XguSJytLxFF9Vzuq02eLSLLh6ROb7ZSh9KKiHwHZS54kMc+QHnBb3Bsti1mCHKN
 ebDX236PlsD0D07Wi/h8BownvTESXIXf3qMprdFaK7OZJhe1NuvS5cKKzrt1YLA2ACtX
 9xlgwaMiyG41pUfmYC+yK4kS2jvX1HQJbPAj5Fcat71iXdOR4MX+u6qNndiPPd7WY+P8
 cXAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoklKxlb1fS2J7Txn50kP4mfk/W35KzslT7SRA7kHIJ7ROhmrwjV3ErKNz9K9dNZ/4Dh6cfYE=@lists.denx.de
X-Gm-Message-State: AOJu0YxBUlhCzU3XfS/m0DovVxOshoxrT4zbVmw750iPrk8mWkBEP9SO
 VVAJAQ69tN+t+OyAuHhZypX5YMRYlLUJlybv3+j4eYRdemaPRehdN0rV0eyTMPDCwOI=
X-Gm-Gg: ASbGncu2Hh0u8JnBNh86SVfQ2NLVay6eR6oEPl9PE6V7RuAb2HLvntvAy7rfWsyHlW9
 kKaQW8bct7h2IhgQ2XbvgeOD+hSBC2hkklMJ8BKFO6zNQxuRjcQXBwoBY/iFYnBPn+854Yb0xoF
 JVOAQZDT5ljsAMik02Lk34AhVaQDZCYRiKDaERsZNLw8a4qBVy8jsldd+OEx69FCtvqEMQRUoBX
 FnRXYuWLG40+v8vo/4dC5mtAagZz+tShg5cyohNoCsEn+t10E7pmvS3DjEPoTVzniIQOTM4PVXk
 /M5sD9FD65g/ebIrwYPJaQ5z5emERkYcfHGyT14jQZ1ShRSS132RGhRDcvFhvkQFRc0kEifiCOb
 W9X+JywaDWnPAAvQldLsVnMVIXrLTfTrkoWvJn7h80vNAxnBq+EBmrSbUCK33aCPjeGYy2k1XVQ
 mEho92
X-Google-Smtp-Source: AGHT+IEKZudMco045p4rrolpKvEcMd9cD7ztGAWfG1vvfQoxZlLF5r6P8vCSGdD1iFyYT92pOS67Og==
X-Received: by 2002:a05:6e02:1569:b0:424:69b:e8bb with SMTP id
 e9e14a558f8ab-42d816125b9mr2878095ab.9.1759244362711; 
 Tue, 30 Sep 2025 07:59:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-573af039e15sm2234798173.30.2025.09.30.07.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 07:59:22 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:59:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: E Shattow <e@freeshell.de>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.denx.de, git@xilinx.com, Marek Vasut <marex@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] env: spi: Fix gd->env_valid for the first write
Message-ID: <20250930145919.GZ6093@bill-the-cat>
References: <1684bd0d-b831-43e6-8713-95a2675957db@mailbox.org>
 <39f7c9df-9a8a-447d-8689-4f99676fb1e8@amd.com>
 <48de987c-1255-4c90-8477-964d153809d3@amd.com>
 <401851f4-36e7-4e11-9d2e-e85753d916bf@mailbox.org>
 <e436dd80-3693-472b-b9f6-5d27a8310397@freeshell.de>
 <49902e34-a01d-422b-bd60-e97aef7d859e@amd.com>
 <88692c72-1c86-45d3-bf2b-1a21debc5785@freeshell.de>
 <a69aecba-186e-4ce4-ba8f-2c72b1d94267@amd.com>
 <b5d83815-a4cc-43d1-a770-4553c3431e9e@freeshell.de>
 <2e6c0670-0ecf-47b8-ab86-5fa31ae3605b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mJH1VVJ7dtLnvy4z"
Content-Disposition: inline
In-Reply-To: <2e6c0670-0ecf-47b8-ab86-5fa31ae3605b@amd.com>
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


--mJH1VVJ7dtLnvy4z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 03:28:38PM +0200, Michal Simek wrote:
>=20
>=20
> On 9/30/25 02:32, E Shattow wrote:
> >=20
> >=20
> > On 9/29/25 05:36, Michal Simek wrote:
> > >=20
> > >=20
> > > On 9/29/25 11:49, E Shattow wrote:
> > > > Hi Michal,
> > > >=20
> > > > On 9/29/25 00:08, Michal Simek wrote:
> > > > >=20
> > > > >=20
> > > > > On 9/23/25 23:18, E Shattow wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 9/22/25 07:51, Marek Vasut wrote:
> > > > > > > On 9/22/25 4:02 PM, Michal Simek wrote:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > On 9/11/25 07:40, Michal Simek wrote:
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > On 9/11/25 05:28, Marek Vasut wrote:
> > > > > > > > > > On 9/10/25 9:26 AM, Michal Simek wrote:
> > > > > > > > > > > In case of ENV_INVALID (uninitialized variables) the =
first env
> > > > > > > > > > > location
> > > > > > > > > > > should be used for storing variables.
> > > > > > > > > > > That's why change the logic how env_valid is setup to=
 be aligned
> > > > > > > > > > > with
> > > > > > > > > > > offset calculation.
> > > > > > > > > > > This will also fix the print about Valid environment =
is showing
> > > > > > > > > > > proper
> > > > > > > > > > > location where variables are saved for the first time.
> > > > > > > > > > > And also fixes behavior where the first two writes we=
re going
> > > > > > > > > > > to the
> > > > > > > > > > > first location instead of the first to the first loca=
tion and
> > > > > > > > > > > second to
> > > > > > > > > > > second location.
> > > > > > > > > > >=20
> > > > > > > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > > > > > > ---
> > > > > > > > > > >=20
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - Simplify commit message
> > > > > > > > > > >=20
> > > > > > > > > > > Origin commit message with more technical details.
> > > > > > > > > > >=20
> > > > > > > > > > > When both location for variables are not valid (or em=
pty) gd-
> > > > > > > > > > > > env_valid is
> > > > > > > > > > > 0 (ENV_INVALID) which is setup by
> > > > > > > > > > > env_sf_load()/env_import_redund()/env_check_redund() =
calls.
> > > > > > > > > > >=20
> > > > > > > > > > > When saveenv is called in case of SPI env_sf_save() i=
s called
> > > > > > > > > > > which
> > > > > > > > > > > contains logic which describes new/old variable locat=
ions.
> > > > > > > > > > >=20
> > > > > > > > > > > if (gd->env_valid =3D=3D ENV_VALID) {
> > > > > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 env_new_offset =3D CO=
NFIG_ENV_OFFSET_REDUND;
> > > > > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 env_offset =3D CONFIG=
_ENV_OFFSET;
> > > > > > > > > > > } else {
> > > > > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 env_new_offset =3D CO=
NFIG_ENV_OFFSET;
> > > > > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 env_offset =3D CONFIG=
_ENV_OFFSET_REDUND;
> > > > > > > > > > > }
> > > > > > > > > > >=20
> > > > > > > > > > > In case of ENV_INVALID option the first location is u=
sed (else
> > > > > > > > > > > part)
> > > > > > > > > > > and variables are saved with ENV_REDUND_ACTIVE flag.
> > > > > > > > > > > The second location flag is rewritten to ENV_REDUND_O=
BSOLETE.
> > > > > > > > > > >=20
> > > > > > > > > > > And
> > > > > > > > > > > gd->env_valid =3D gd->env_valid =3D=3D ENV_REDUND ? E=
NV_VALID :
> > > > > > > > > > > ENV_REDUND;
> > > > > > > > > > > is executed. env_valid is ENV_INVALID that's why ENV_=
REDUND is
> > > > > > > > > > > setup
> > > > > > > > > > > but that's not correct because the first location has=
 been written
> > > > > > > > > > > and not
> > > > > > > > > > > the second one.
> > > > > > > > > > > That is confirmed by
> > > > > > > > > > > printf("Valid environment: %d\n", (int)gd->env_valid);
> > > > > > > > > > > which is showing number 2 (ENV_REDUND).
> > > > > > > > > > >=20
> > > > > > > > > > > That's why change the logic how env_valid is setup to=
 be aligned
> > > > > > > > > > > with
> > > > > > > > > > > offset calculation which also cover the case where in=
itial
> > > > > > > > > > > state is
> > > > > > > > > > > ENV_INVALID.
> > > > > > > > > > > Then print about Valid environment is showing proper =
location
> > > > > > > > > > > where
> > > > > > > > > > > variables are saved for the first time.
> > > > > > > > > > > But also it is fixing behavior where the first two wr=
ites are
> > > > > > > > > > > going
> > > > > > > > > > > to the
> > > > > > > > > > > first location instead of the first to the first loca=
tion and
> > > > > > > > > > > second to
> > > > > > > > > > > second location. Alternation is happening after it.
> > > > > > > > > > >=20
> > > > > > > > > > > v1: https://lore.kernel.org/
> > > > > > > > > > > r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540=
=2Egit.michal.simek@amd.com
> > > > > > > > > > Sorry for not being clear, the original commit message =
structure
> > > > > > > > > > and
> > > > > > > > > > technical details were fine, it only needed slight reph=
rasing, in
> > > > > > > > > > the original form it was very hard to understand. Can y=
ou please
> > > > > > > > > > reinstate the original commit message and only clean it=
 up
> > > > > > > > > > slightly ?
> > > > > > > > >=20
> > > > > > > > > Can you exactly point me to part which wasn't clear? It h=
as a lot of
> > > > > > > > > details about flow and obviously it makes sense to me tha=
t's why I
> > > > > > > > > would like you to point me to exact part which should be =
improved.
> > > > > > > >=20
> > > > > > > > What about this?
> > > > > > > >=20
> > > > > >=20
> > > > > > > > When both SPI environment locations are invalid (gd->env_va=
lid =3D=3D
> > > > > > > > ENV_INVALID), the first call to saveenv writes to the prima=
ry
> > > > > > > > location
> > > > > > > > and sets the active flag. However, the logic for updating g=
d-
> > > > > > > > > env_valid incorrectly sets it to ENV_REDUND, which does n=
ot match
> > > > > > > > > the
> > > > > > > > actual location written. This causes the first two writes t=
o target
> > > > > > > > the same location, and alternation only begins after the se=
cond
> > > > > > > > write.
> > > > > >=20
> > > > > > nit, the use of word "alternation" here reads as splitting (no
> > > > > > duplication) the data one-by-one into multiple targets. I would=
 give
> > > > > > the
> > > > > > game analogy of 52 playing cards and alternating to deal the ca=
rds to
> > > > > > players, each player gets one card in a sequence of alternation=
; if
> > > > > > there is more than one player in the game then no player will g=
et all
> > > > > > the cards from the action of dealing the cards.
> > > > >=20
> > > > > tbh before this patch I though that both copies are the same but =
that's
> > > > > not how it is implemented.
> > > > > It is switching from Location A to B and then to A, etc.
> > > > >=20
> > > >=20
> > > > Okay. That is also surprising for me.
> > > >=20
> > > > > >=20
> > > > > > > >=20
> > > > > > > > Update the logic to alternate gd->env_valid based on whethe=
r the last
> > > > > > > > write was to the primary or redundant location, ensuring th=
e first
> > > > > > > > write sets ENV_VALID and subsequent writes alternate as exp=
ected.
> > > > > > > > This
> > > > > > > > aligns env_valid with the actual storage location and fixes=
 the
> > > > > > > > alternation sequence from the first write.
> > > > > > > >=20
> > > > > > > > With this change, the "Valid environment" printout correctl=
y reflects
> > > > > > > > the active location after each save, and the alternation be=
tween
> > > > > > > > primary and redundant locations works as intended from the =
start.
> > > > > > > Yes, perfect.
> > > > > >=20
> > > > > > I do not understand what this description is saying because alt=
ernation
> > > > > > of write operations to multiple targets would not be redundant.
> > > > > > Alternation with the meaning of "fail-over" is similarly not re=
dundant.
> > > > >=20
> > > > > How the code is written is that you have location A and B.
> > > > > And when you call saveenv variables are written to A.
> > > > > And next saveenv variables are written to B.
> > > > > Next to A, etc.
> > > > >=20
> > > > > It means unless you call saveenv twice you never get data in A an=
d B
> > > > > equal.
> > > > >=20
> > > > > It means it is not alternation of write operations to multiple ta=
rgets.
> > > > > It is alternation of location where one complete write is done.
> > > > >=20
> > > > > >=20
> > > > > > An alternative method has the meaning of "do something else, do=
 not do
> > > > > > this". In the common use, an alternative may have the meaning o=
f "do
> > > > > > something else if needed as fail-over from what is first being
> > > > > > attempted". Do you intend for the meaning of "fail-over" and
> > > > > > "duplicate"
> > > > > > or "duplication" where you have written "alternate" and "altern=
ation"?
> > > > > I am not a native speaker but the word alternation between A/B so=
unds
> > > > > the best for me.
> > > > > Feel free to suggest how to describe it better.
> > > > >=20
> > > > > Thanks,
> > > > > Michal
> > > > >=20
> > > >=20
> > > > This is not easy to describe with a small quantity of words. The co=
mmon
> > > > phrases are "taking turns" and/or "round-robin".
> > > >=20
> > > > It is clearer to say what this is not, as:
> > > >=20
> > > > "... results in alternation of saveenv location with each invocatio=
n.
> > > > Data is not duplicated or striped between locations for any single
> > > > saveenv invocation."
> > > >=20
> > > > I like your explanations, you understand the functionality and can
> > > > describe the problem clearly. I just do not expect that functionali=
ty
> > > > would be useful so without additional context and full explanation =
it
> > > > seems unlikely to be what you say it is. Thank you for expanding on=
 the
> > > > meaning.
> > >=20
> > > What about this full description?
> > > M
> > >=20
> > > When both SPI environment locations are invalid (gd->env_valid =3D=3D
> > > ENV_INVALID),
> > > the first call to saveenv writes to the primary location and sets the
> > > active flag. However, the logic for updating gd->env_valid incorrectly
> > > sets it to ENV_REDUND, which does not match the actual location writt=
en.
> > > This causes the first two writes to target the same location, and rou=
nd-
> > > robin switching only begins after the second write.
> > >=20
> > > Be aware that data is not duplicated or striped between locations
> > > for any single saveenv invocation.
> > >=20
> > > Update the logic to perform round-robin selection of the environment
> > > location
> > > based on whether the last write was to the primary or redundant locat=
ion,
> > > ensuring the first write sets ENV_VALID and subsequent writes follow =
the
> > > round-robin pattern as expected. This keeps gd->env_valid consistent =
with
> > > the actual storage location and fixes the sequence from the very first
> > > write.
> > >=20
> > > With this change, the "Valid environment" printout correctly reflects=
 the
> > > active location after each save, and round-robin switching between pr=
imary
> > > and redundant locations works as intended from the start.
> > >=20
> >=20
> > Michal, great and we can condense that to terms of location (and not so
> > much write operations that are now the most confusing word use)?
> >=20
> > My edit is as following:
> >=20
> > START
> >=20
> > Update the environment location selection logic to perform
> > {alternating,round-robin} selection of the environment location based on
> > whether the last write from a call to saveenv was to the primary or
> > redundant location. Ensure the {first,initial} {write,call to saveenv}
> > correctly sets ENV_VALID so the subsequent calls to saveenv follow the
> > {alternating,round-robin} pattern as expected. This keeps gd->env_valid
> > consistent with the actual storage location and fixes the sequence from
> > the very first write.
> >=20
> > Prior to this fix the {alternating,round-robin}
> > {switching,change,assignment,selection} of locations would begin only
> > after the second call to saveenv.
> >=20
> > With this change, the "Valid environment" printout correctly reflects
> > the active location after each save, and round-robin switching between
> > primary and redundant locations works as intended from the start.
> >=20
> > {in absense of a cover letter then insert triple-hyphen here so git will
> > ignore the remainder with more technical details not intended for the
> > commit message}
>=20
> Commit message is IMHO location where technical information should go.
> I can't see any reason to skp them.

I very much agree. Especially on a patch like this where we've spent a
great deal of time discussing the commit message (as the situation being
fixed is very complex). Someone looking at this in a year or three will
be much happier with a long commit message they need to digest than a
short message that leaves them with questions.

--=20
Tom

--mJH1VVJ7dtLnvy4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNvwQwAKCRAr4qD1Cr/k
CtLXAQDDnIlvNwf1YlcE4W/mvu6dFPHGoRWcsqZkbmnjKetUfQEA3rgVyWKTNXfG
TCPSyIULMdx9BwiXSG4OZikGPiOUpAM=
=A4CB
-----END PGP SIGNATURE-----

--mJH1VVJ7dtLnvy4z--
