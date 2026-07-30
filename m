Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CD4C531D0
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 05:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A292A80C80;
	Thu, 30 Jul 2026 05:18:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9ffTJRQVNZF; Thu, 30 Jul 2026 05:18:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 916BB80E01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785388713;
	bh=BDggf69DOJZp3QBM31zmBunQjdjqnUREvzM4xA8eefk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LRnY+cwhbrz6GJQj0vsJRf0H1UI8v78rdWk3cIxY1Kv5xKdVvhyi92nIte3bWUOj4
	 Uw1lxUbs4nIxB8nKzY9p3nHE7uNd5Ki0992aj1zec7K5J+83xYBgOtYAOSXRHyUhCL
	 WbUXjld7u6ZOblzAWlyEXbRgVC41/iIZrbVxUxNIghEDTdINXsearZpG5cu5v2LEYV
	 t6mKNvu+eHjzWxay8jWgHfUfzSJod3h9RWK6RllZ2tRQyE5BPdPySxK97+UA1oRkQU
	 0E3Og3j7wOhVy/QatmEZ3XKmYTs8q0fSxQbV1jGpJW178ZGUXVPhrqRc9XdRqyARp0
	 GfLYzTqtiVGcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 916BB80E01;
	Thu, 30 Jul 2026 05:18:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B099127C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 05:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADFCC40187
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 05:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S5Dif71LuCah for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 05:18:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A4B8B4004D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4B8B4004D
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4B8B4004D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 05:18:29 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5b2aab18795so1559853e87.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785388707; cv=none;
 d=google.com; s=arc-20260327;
 b=iM/ajTjHz+3mr0j5OKwBzR/og0EZqD1TmAtoqAwAVHRUZp5Y3c8PO5+Dh5kJsC+Rjb
 Ux8/pPwSs6RGFUf8sjnRut39CTBdMKklwlZld5pjZQN7Tv3MkxgZKJbO9xEkiULOECz3
 L+mi5zdDhNSAAxw1yfRcf+IrbZhRHVerQK+JbtziOXnxinxHFRKj0sTVoSwU3oS82c90
 PBh2+fZ5rK5jB0JaYGQ0AovOYAEPqQk/spK2VveKSeeA0oVfpWuBKduNxhchA/BAZVt0
 +yxEo0O3sczjK661AMWGf1xwpXAz0JjUeTG9gkJOky0pG5i3XVbGn+A6yuDw6mIrpLJT
 RNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BDggf69DOJZp3QBM31zmBunQjdjqnUREvzM4xA8eefk=;
 fh=1EqYmiAmoJtQDOaI6AIS3tSckIM65oNDX3ULHybOIB4=;
 b=sCwkx05d1v71adqzxE1Ipu3wgqbTe+EOZJCqibeoeCV9hRCpfw7RhkZMsEfk09FDHP
 IDkdz5p+psKqART+bALWQnSrT0+x2k4vpiTImww7S9bjaMt+3CKjelaCLBK7XazPaoEX
 ippbQKG3he8l21nrAesKivOEr8sxfoqmX4PxoJSP2qPmEl9A+VamQyKXTL6GBx7P1Mnq
 86846i65DK639DXoCDSnf4LmN30sb44O/w6YbGRaIky21E8nRWtwbzJevbW8pkwbcO2P
 5bYQURmxlMgjrkV3I70S7kkEMzOFqcGMEEKx7rmLD36LFGBesqEYIbMFk4o+9q4LYnVM
 mTtA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785388707; x=1785993507;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BDggf69DOJZp3QBM31zmBunQjdjqnUREvzM4xA8eefk=;
 b=Eea/WCzE43EL+snBWygNUqX6hNa3qk9pPssIEj0GIZ73nO4vbYkCjsc29m2wV0dzK2
 lYcOaiNEBJTUN8VhyxpyjIDxCCNWPu3cMXVCjLtuDxrpoEn12Yws5yCXvtqSwEkLYtty
 Yck9DE9jokWJuZQOH21MQ/V7cmn2NWVczKqJopwFNIxJ+dXH9Xd746az+dcv4ffasuwx
 bq13Ir1UpTU6e6Rzr7kFVOcLCoTFGeVfyC2hyLGY1FIhY3W8oB4qnNcfXNII2QL3694q
 eCQPhKq6NlEaEj7tUugh75JUvNrwC8FBx3hqaACvaQw8nCFxh0ezo3xXQuycqwPlCSnp
 aOzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHqW01PUfyVbbHvYg3u+zPReV8xrS6HzWxRNQFugkwOc15ISb+4InNEUbuKxHM08UX3jaYamA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzvUXWJqKQNDWqG3w9yiq3UXd1XLoxiHdVhu8I+ezP1HqKpaosz
 Plt/FayZsVRbAkdscKjaC5x1cB5vpo+tEQHf0BlzO9sXtbSQfZtxUMbththxJaSbzfcm0QBJfGC
 MNp83pbpet/cTakN8s9gSt4HOh4b6bHVQjR6tZs2z0g==
X-Gm-Gg: AR+sD12UTT0Z1RX8iNCEtfDvvEGWo4KfOqJCM5ntl+NYTup2NRX6KPp39RF+yXokn/n
 1dsqfixUY+pfVUvvXTERGRnxdQV6QIC7SD9OxYEBVIwy+gFVxaCp+zU12IAgdIGAsFhhESB0HzS
 hjoYO8fHRZ7Jn7NolCuaNoQag+dkmEIAJTM6bllhkYt77ytkHKgm1jFMP3JfuGO5HFJRoirw1BC
 L+llKB/emR3rDelhc1s5n+u9q1hLObsUO1757WHE0hQ1qdo0KphQOvGHCYmpAKZgbi4qjyXJOGF
 oAsOEBkKLn4KCg2wJOT020i4g4DR4l0Rd2S6dkINVYjOQqzLxPGjASRabwi/KWgAkXRWEJHsO3O
 Cv3dwXF+JVE9eZIv0H7s1ZhjrV+bugMi1Ap3ktP4A8wIY5i4nVVrJ+K6/336LixUJpMqEbj8wFq
 kItw==
X-Received: by 2002:a05:6512:6695:10b0:5b1:5b10:523a with SMTP id
 2adb3069b0e04-5b2db391f3amr100565e87.62.1785388707009; Wed, 29 Jul 2026
 22:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-6-2f58566d48ca@riscstar.com> <amdGSBKT4iRzuh1P@pie>
 <CAH22mJz64S5_em=D0zvt1uUaGpymAb1Ss5uiB5OkutpRcU=6Og@mail.gmail.com>
 <ameQUN3zlD0Ei8Jm@pie>
 <CAH22mJyMqTgRLqyfVZGgSHHNK7XnBTnrkY-R1ix5DN+oiBDEbg@mail.gmail.com>
 <amhyAULw9Wovuo3z@pie>
 <CAH22mJyyExBuUrDNgRg=WU4f6RkN7M0QhtuUAgXiUf8b84TaCQ@mail.gmail.com>
 <amojCjayE5-wI7iT@pie>
In-Reply-To: <amojCjayE5-wI7iT@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Thu, 30 Jul 2026 13:18:14 +0800
X-Gm-Features: AUfX_mwXRzIPNIXwgnSYmui_OvUAu--tpzz1TQdcOXyfVMlK8ZwLq2elUTM88MI
Message-ID: <CAH22mJzTu186fyLfT18WTS7RBL+2u77adGMTmY+0jUFgZdtCgA@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] dts: k1: add SD card support in u-boot overlay
To: Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785388707; x=1785993507;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BDggf69DOJZp3QBM31zmBunQjdjqnUREvzM4xA8eefk=;
 b=gMces15TEgXWcIFloPfBIIpx0dhfLDhfcJduJxLPGj1QzS6/+h/VNe3vd7nhDLnpov
 XXAuJDYc7b7aS1pC8WfWHFUdpvLj0ro56kLi28n3q/x7YyIdeh+owvNxw9S19IAFaGIj
 0tUFOM/9n1tHY9U8/nH6vw3Iz0e6gEsdUvV97K6ItQ74TLjVdTHgIYG9CYxjvFJ9PrpD
 hv6jOjgvfhF4MbIKgpPAts4MHT85CkWIkg/7W9U//RRphCx9kpb1gYGEBZ0K1QnFkE1t
 IR1hJpR0Ape6NcSiuRShib6HF3GBTg+mAIUV6xbH0+5lifajZpexMfY6mq0XhL+LVr9m
 wuhg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=gMces15T
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, Jul 29, 2026 at 11:58=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
>
> On Wed, Jul 29, 2026 at 10:05:14PM +0800, Eric Chung wrote:
> > On Tue, Jul 28, 2026 at 5:11=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
> > >
> > > On Tue, Jul 28, 2026 at 09:04:52AM +0800, Eric Chung wrote:
> > > > On Tue, Jul 28, 2026 at 1:08=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
> > > > >
> > > > > On Mon, Jul 27, 2026 at 09:08:52PM +0800, Eric Chung wrote:
> > > > > > Hi Yao,
> > > > > >
> > > > > > I'm not familiar with the policy for syncing DTS files from the=
 Linux upstream.
> > > > > > Could you clarify how this script works?
> > > > > >
> > > > > > Does it sync all DTS files from Linux upstream at once, or is i=
t
> > > > > > possible to sync
> > > > > > only the Spacemit DTS file?
> > > > >
> > > > > update-subtree.sh cherry-picks a commit from the upstream, or
> > > > > merge an upstream tag into the subtree. Cherry-picking SD-related
> > > > > commits from Linux upstream suits for your case.
> > > > >
> > > > > > If I choose to sync only the Spacemit DTS file and include it i=
n my patch set,
> > > > > > would that cause conflicts later when others try to sync all DT=
S files?
> > > > >
> > > > > Tom synchronizes the dts subtree with Linux upstream irregularly,=
 there
> > > > > should be no conflict or relatively small ones if you cherry-pick=
 the
> > > > > changes, while adding downstream nodes in *-u-boot.dtsi might suf=
fer
> > > > > from duplication, too, during synchronization.
> > > > >
> > > >
> > > > The process is a bit complex. Since my main issue is that the DTS
> > > > files are out of
> > > > date, would it be simpler if I just copy the relevant Spacemit DTS
> > > > files directly
> > > > from the Linux upstream into the dts/upstream folder?
> > >
> > > The answer is simply no.
> > >
> >
> > OK. I'll keep using my own overlay DTS file.
> > I tried upstream DTS file. It only gave me more bugs. I could switch to
> > upstream DTS file when Tom syncs it.
>
> So first of all, please note switching to upstream devicetree doesn't
> mean you must remove all the dts overlays, you could keep small pieces
> like these adding bootph-pre-ram properties, which are
> bootloader-specific and might not get upstreamed in a short period.
>
> And I noticed there have been quite a lot code in the overlays, like the
> PMIC code, thus changes to overlays might be huge when cherry-picking,
> if it's the case, this patch is then acceptable, but please mention it
> in the commit message.
>
Yes, it's one of the reasons. Too many related commits exist. I prefer to k=
eep
the process simple. When someone syncs the whole DTS, the process is
much easier and avoids commit conflicts.

> But, if switching to the devicetree with cherry-picked patches for MMC
> leads to bugs, there are likely ABI compatibility issues in your driver,
> which would persist even after the synchronization with upstream v7.2
> tag. Please fix them. From the very start, it's agreed compatibility
> with Linux devicetree ABI is important[1].

There are several commits on DTS. Cherry-picking only a few commits is
not ideal.
I'm using upstream DTS. I just keep minimal changes in the overlay DTS file=
.

The cd-gpios property isn't even consistent between bananapi f3 and musepi =
pro
board.

The sequence of mmc nodes is also inconsistent. SD node is declared
first, and the
eMMC node is declared second. However, there is an alias that reverses
this order.
In order to make it work, I have to enable CONFIG_DM_SEQ_ALIAS.

As I said they could be fixed. And I failed to cherry-pick only a few
commits. So I don't
want to import commit conflicts when I synchronizing DTS files. I
prefer it could be
handled by maintainers. When it's done, I can continue to submit new
patches for fixes.

It should be fixed in Linux. But that doesn't mean I must fix the
error in Linux first.
Then I submit this patch set after 6 months, waiting for the fix to
merge in Linux.

>
> So here's my NAK for this series, including v7 of it.
>
> Thanks,
> Yao Zi
>
> [1]: https://lore.kernel.org/all/20260429-glare-anybody-16c98d01184e@spud=
/
>
> > > > > > Best Regards
> > > > > > Eric
> > >
> > > Regards,
> > > Yao Zi
> > >
> > > > > By the way, please avoid top-posting if possible.
> > > > >
> > > > > Thanks,
> > > > > Yao Zi
> > > > >
> > > > > > On Mon, Jul 27, 2026 at 7:52=E2=80=AFPM Yao Zi <me@ziyao.cc> wr=
ote:
> > > > > > >
> > > > > > > On Mon, Jul 27, 2026 at 02:59:08PM +0800, Eric Chung wrote:
> > > > > > > > Add the SDH0 controller node and its pinctrl groups to the =
u-boot
> > > > > > > > overlay. The upstream DTS only contains the eMMC node; the =
SD card
> > > > > > > > controller (sdhci@d4280000) and its MMC1 pinctrl configurat=
ion are
> > > > > > > > missing. Place the new node inside the storage-bus via path=
-based
> > > > > > > > merge so it inherits the dma-ranges from the parent bus.
> > > > > > > >
> > > > > > > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > > > > > >
> > > > > > > Please cherry-pick upstream devicetree changes from Linux ups=
tream with
> > > > > > > tools/update-subtree.sh instead of adding our own copies. Cha=
nges for
> > > > > > > k1-bananapi-f3 and k1-muse-pi-pro have both landed in Linux v=
7.2.
> > > > > > >
> > > > > > > Best regards,
> > > > > > > Yao Zi
> > > > > > >
> > > > > > > > ---
> > > > > > > > v5:
> > > > > > > > - Append power source field on eMMC/SD pinctrl.
> > > > > > > > v3:
> > > > > > > > - Fix SD pinctrl as uhs.
> > > > > > > > v2:
> > > > > > > > - Use vmmc-supply as vqmmc-supply on SD node.
> > > > > > > > - Add alias of mmc0 and mmc1.
> > > > > > > > ---
> > > > > > > >  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 91 +++++++++++=
+++++++++++++++++++-
> > > > > > > >  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 86 +++++++++++=
+++++++++++++++++-
> > > > > > > >  2 files changed, 173 insertions(+), 4 deletions(-)
