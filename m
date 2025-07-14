Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC1AC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 19:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 502D38300B;
	Mon, 14 Jul 2025 21:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HT2oP+iL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01CD183020; Mon, 14 Jul 2025 21:17:00 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3C3882F8E
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 21:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ae3b37207easo951598866b.2
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752520617; x=1753125417; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8R3Cl4CBnaMd3DLUoSMGMgXBCVQzgTSpuWUtXS2av8=;
 b=HT2oP+iLp9PEOFO4keabbnqYP3e4THT2kF3AIzudH0ZyERagnNTsg2G4ZG55mqm1ib
 kw8aM0oNEjHGN0zMn53mvlAv4up7xuVXdnYmUFk3F/r8iPNl2EWgivp36/1uV6xX+rCV
 vsxHsPiSCODiGjWGIvFGB+oU9mwAWGCDp8HTwAW7hIdehItclZMRmbgvQg17mBuse6fL
 qJ+Zqe5c2v5ao9YS9sWEJ8O3sMnfOFP9MEJ8Uwa4fWlaQDDaZd46BF5iUOzLo0tdfjDA
 v0PETjHjETP9nWjFrbTQkNkoHeAMbtqwmk2RwmJzOaVF9cfHY/72xlqhlSDPow09uW1M
 Jksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752520617; x=1753125417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8R3Cl4CBnaMd3DLUoSMGMgXBCVQzgTSpuWUtXS2av8=;
 b=KFlqQLhshG6632BPRd3pSVQrCgNFKCI8UB9uze4g0pblXgHdBFQFQDvqLTYjAZJKwi
 B/3Z/duqxQWeliWxkYSchWY4p0AAkyK9NG2Zi6SIX2T271AD5Xmi66o+yo53/kMrBb1x
 n1g5IfON4PZW8FKqjlqYl19lUODNPVx/+jXIyM8pe86Ph7UVf94pCKZJzdbd0/i3fm0v
 UKibiSiyBsn3WV1WE/U0KiI9a5BgSvm2kOBoGzFXkldE1YweY24UvycLBa97loA/mxXl
 ToKbU0k3mF4zRrtdQLDLHN4MoU1sZrMaLMHhtwqgQvNgsrcxjBVFA8/WHImJemRXTkss
 vy/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlX6RzZz0jvU3tGP1DAWOvRR9Nz1Ohbdf0UKN8kI2q5i33ewm3zXApR15PiBciN3GiGk5irWg=@lists.denx.de
X-Gm-Message-State: AOJu0YzHbJDZjqLdOc+TZ65k0l5gPg9RtFC092j4D/L0N1eXP0IpF5FH
 ZJfuumcNoFVmv2PFkSPYss0gjigGBhKf/+X1eqMJkezaxGxyh5v0v+2sbTnfQiikP2DW4pm7q34
 jS/7Em+gVMU5Ruju6dly7Uxr40Aow+3Uw
X-Gm-Gg: ASbGncv+9QewkdPB2PBldMmjg1lDqeAIL6yKq+HIcgsAfbCcNTEUHY73ZD/q3p7/+kD
 sZ2aJTz5SY7ADxu8q1Hewzg/1P8ckpKb18gBHnNGUbLHSgGH0H3i7JiB9phbA1snDHMjF7+sScr
 m7a6vj1A6bs8hyt+k24bZOeCdVLnpeLuXwV9lGoeHyz11L3ZHdcH5cvL32Miloq48l9lU+McU8N
 OHJIW1NM9jmwFWx+0keZI1+XDZMzKGDWjZcQr0=
X-Google-Smtp-Source: AGHT+IGHBHCd7zURXVwrFr/nxsb1rXxflk2tZbrZZsa506/TIMJx5fj6UYzqr4kAaH3SKMS4pjRsvrwervOlbidsTEk=
X-Received: by 2002:a17:906:9f8c:b0:ae0:9363:4d5d with SMTP id
 a640c23a62f3a-ae6fbc13b3emr1532069366b.2.1752520617008; Mon, 14 Jul 2025
 12:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250714-blk-uclass-v1-1-d21428c5f762@linaro.org>
 <20250714162951.GI13084@bill-the-cat>
 <04953cfc-0475-4560-bd7c-fee27739e351@linaro.org>
In-Reply-To: <04953cfc-0475-4560-bd7c-fee27739e351@linaro.org>
From: Greg Malysa <malysagreg@gmail.com>
Date: Mon, 14 Jul 2025 15:13:26 -0400
X-Gm-Features: Ac12FXxnkUm7_7MszWr8c-61a1elJg_4HwgA3GhY5dFKeVKQ8FOg7fIVqlsvboM
Message-ID: <CABdDSeVtccemn8PTgs-f+QzZqJDZ_R=GRmrK2wquasCYDwWYPQ@mail.gmail.com>
Subject: Re: [PATCH] block: Remove unreachable code
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Tom, Andrew,

On Mon, Jul 14, 2025 at 1:12=E2=80=AFPM Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> On 14/07/2025 17:29, Tom Rini wrote:
> > On Mon, Jul 14, 2025 at 04:38:53PM +0100, Andrew Goodbody wrote:
> >> The two functions blk_find_first and blk_find_next use a for loop with
> >> the content being a 'return 0' which means that the 'increment' code i=
s
> >> unreachable so remove it and also remove the variable ret which is
> >> assigned to but its value is never used.
> >>
> >> This issue found by Smatch.
> >>
> >> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> >> ---
> >>   drivers/block/blk-uclass.c | 14 ++++----------
> >>   1 file changed, 4 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> >> index f3ac8db9464..b38c21ffbe2 100644
> >> --- a/drivers/block/blk-uclass.c
> >> +++ b/drivers/block/blk-uclass.c
> >> @@ -613,11 +613,8 @@ static int blk_flags_check(struct udevice *dev, e=
num blk_flag_t req_flags)
> >>
> >>   int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
> >>   {
> >> -    int ret;
> >> -
> >> -    for (ret =3D uclass_find_first_device(UCLASS_BLK, devp);
> >> -         *devp && !blk_flags_check(*devp, flags);
> >> -         ret =3D uclass_find_next_device(devp))
> >> +    for (uclass_find_first_device(UCLASS_BLK, devp);
> >> +         *devp && !blk_flags_check(*devp, flags);)
> >>              return 0;
> >>
> >>      return -ENODEV;
> >> @@ -625,11 +622,8 @@ int blk_find_first(enum blk_flag_t flags, struct =
udevice **devp)
> >>
> >>   int blk_find_next(enum blk_flag_t flags, struct udevice **devp)
> >>   {
> >> -    int ret;
> >> -
> >> -    for (ret =3D uclass_find_next_device(devp);
> >> -         *devp && !blk_flags_check(*devp, flags);
> >> -         ret =3D uclass_find_next_device(devp))
> >> +    for (uclass_find_next_device(devp);
> >> +         *devp && !blk_flags_check(*devp, flags);)
> >>              return 0;
> >>
> >>      return -ENODEV;
> >
> > Should we clean up uclass_find_next_device(...) to not return int? The
> > function comments don't quite make sense (include/dm/uclass-internal.h)
> > and it always returns 0.
>
> OK, that should not be too bad.
>
> Andrew

To me it looks like this function doesn't do what is advertised in
include/blk.h in either case (find the first block device with
matching flags by checking each one until one matches or we run out),
instead it seems to test the first block device for the flags
requested and either returns -ENODEV or 0. Out of curiosity, i looked
for uses of blk_find_first and blk_find_next, and (except for
test/dm/blk.c where all the functions are used) they're only used by
the blk_foreach macro (include/blk.h again), which is only used in
blk_foreach_probe, which is only used in blk_count_devices, which is
used nowhere. Instead users use blk_first_device_err which is a
completely separate path (drivers/block/blk-uclass.c:638).

I was hoping the test code could clarify a bit and it might. In test/dm/blk=
.c:

dm_test_blk_flags first looks for devices with either flag (BLKF_BOTH)
so the flag check never fails, then it looks for BLKF_FIXED ,which it
indicates must fail because before probing all devices are removable,
then it looks for BLKF_REMOVABLE, which is set for the first device
before probing (even though it will become BLKF_FIXED later). So none
of these are (I think) testing for the situation where the first
device is missing a flag, but the second device has it and
blk_find_first should return the second device. Then in
dm_test_blk_iter, blk_count_devices is used with varying flag
combinations and is expected to give the correct answer, which
suggests that the code does actually work, assuming the test case runs
and succeeds.

I've been looking for something to poke around in and if you're ok
with it I'd be interested in exploring this further to figure out
whether the function does what it is intended to or if there's an
opportunity to improve the test coverage.

Thanks,
Greg
