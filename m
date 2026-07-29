Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55407C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB2DC408A3;
	Wed, 29 Jul 2026 14:05:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nbH1A-6r3ivw; Wed, 29 Jul 2026 14:05:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8297840B07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785333933;
	bh=sJU+ROxdo33pkj4AWYehaglBmU5NkMALTJSYmgHTMGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CVpd16au1FENfZh0syD3d3RnrixY7ssCVR9y57prpmFi/tmd5GQtaB0P4dIAYw0hH
	 2IInU6qduLxDqR0HnGyq5Tg+jo0R+IbkNclOqdGYzLj3CTHI/tO7Eb1xXMmjrhLgr3
	 1Pq1q/+KV1Ms1qTu/vzxDE0ly32pw5IcF5QkpgbM3WuH87TaHYDeZ3drb/R1OjIaNW
	 gYta0fZwBv7mqPYNyd/xrYmUcI2gsMT6MVuarh+IIMDdEaqKO+BhvJGvtxbHhvS/FV
	 NP2AwaFS3fYFmh/55eTbSMsDfpDNdKtEaM5a5cc9xpSNdKHgvfE6BqxFEgnyHHPrFa
	 e4tNalrpt+L2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8297840B07;
	Wed, 29 Jul 2026 14:05:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B879194
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C8F040267
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UmJpu3EgNm2J for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:05:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E88DA40074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E88DA40074
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E88DA40074
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:05:30 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5aeb98460c6so919712e87.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785333928; cv=none;
 d=google.com; s=arc-20260327;
 b=dlyQiIReNEU9Fx59i90OP3+IBQXvMSOKSmSqknwCWMfTHsCg5mZ5yuhd6U9WPnv86E
 KosOZIPMusS9x7KFYuATlNa8e5SzO4ADvk5eGsUpFcZnzd25aW3NTYA6AJIg+27/cvg9
 nqF833rA56E8WD5r1VFWo9Vrfl6F9wu+Vf5gN7Fa/CqJNEnW65V0X2OCnE+SxRwmwJG0
 Pn6PU8NJMtyaVN4dM0xIY9fGWY42IL+2p7LYABGRnROnDo3+6ejtipdESy+0COU99FDV
 YRfPHmN3qFNioZB4GyK2VjF0f8T3AY87rNyoyFHyax4ux3NtxSI65zynPakdrxVAoT0l
 9WIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sJU+ROxdo33pkj4AWYehaglBmU5NkMALTJSYmgHTMGI=;
 fh=vSfkEd6RapT6KDy195vRPFzrFfySQXIaOmo0/M0zGFI=;
 b=Q4bmM7byTKKcBBzWIFalr8lyzuVRdTMejaugLrwvVVHwVlqSgjfcA4eCiD6MPFSeV9
 dQAZugYzCmMBqAATj1H/fSFhanm13rScuKp7KYZGf1bK7Sz7lorCjDHiXh3j2+edTnC3
 m4sR9b4T2YmChU5EGVqjW96/LKqSLtyJExtLY5IcN0yfMk7xiIXClfi4fHUJYQEiDV2E
 omt8L9Afg0HHiwMHhlnOFzTR6wXPBJrfeV3Q5dFDktEEhNU4uGdKaunvAjEh9FR+VSrZ
 4KhiBJioLqSuj36Nb051ZZkNdbt5bqS5Xsi2VeY7pFbC75VEq8P3W+hLpUPwYK0HGJA/
 Hbvg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785333928; x=1785938728;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sJU+ROxdo33pkj4AWYehaglBmU5NkMALTJSYmgHTMGI=;
 b=L7wLURYGZwrgnwd6TPi3Ag1lvPL3/clLbisQ5whQ2st+nTPVSRj1tWvGVb5YlMz6bA
 dalw20/a/smyQnFX8lbGc906wkVgC+NJyue0s1ImVchYxfMo5LSkdDAgxFkpFsVuJODV
 fTwWlLRlm72+CWyCk3Mu2UvZo7GLKRWygzXV1c1u8i2MsekbiZqcW8RjuZ5JpZOoEyHj
 8GH4sMgjGL5/+VjVtp1hQ4XQI+hor/XJteKnS5KtwapKSB+3wov1dM8w6jJt6bgT/ejc
 xyflS925+prTJLXzJPIVPIxXZINrJI8Rz3KJdc9MsUD1CzT9NxzojrpVYUNtn9BvOxha
 Kvnw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpuEGV/fVOCAB2AFCT7BdGDifaJBtuCXNTwU0Kwunl0eq7PudTFTy+5a8HXVRIWESjWm0g41Ps=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwoIW/XpEBN8RQDEriBKQD2NzwRz3+x6moNVKJKQ0VRJLVB7OHg
 yGmEg8yqlJeF9aVw5M5vm5jzuBVADm8iMSg9xDylGxqFFTNwtENvJmyfoHFmane43NdhQSeyJ1w
 JKf+z4bkqww3k8Q/TBAND0os3tkMiLOvCLSecv8gtTw==
X-Gm-Gg: AR+sD12xg/lqYmJ8m7PhtsokByCoqJlD31SirpGfx+52seazdLF3LeBz11gs2uNw23C
 2wrrR4u0hgp7JL+tdXey/Z30Zt9bWbMYs3eMYUF3EjerM5S6Yo+7QvLOZFI3QBdfgN2G+mfm+H7
 j0ekGe5ANtg3mO5hMvFXp89pRT6Ga9DEg8y5k1B5WfcBCbngxyvIFl8A+dq24u5XZPBhkSZd9Jm
 IEo9NuRQvlmwQTn3uj2ImSTXNIKhbMXp1hELdOAiKuAVFStHKs+kPCJqlEXovI4CgAcwy72coWj
 D5wKXDbUpdLkpEsi8mp+PSU4VYWeNsDdJwIcVfvnC5F6K1w321H6oE52hVuPXfYBbHQDRKgRJZ9
 /JRQftaKboqVNJ683TLXwgFjUrh0+T9KHs4C39l60gFSK74H43dOCC/XiK3R8ZHFBLpGhWIl8Sq
 57n2EDVNurxNyO
X-Received: by 2002:a05:6512:1151:b0:5b1:5f28:2198 with SMTP id
 2adb3069b0e04-5b2d020fed2mr1490360e87.3.1785333928206; Wed, 29 Jul 2026
 07:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-6-2f58566d48ca@riscstar.com> <amdGSBKT4iRzuh1P@pie>
 <CAH22mJz64S5_em=D0zvt1uUaGpymAb1Ss5uiB5OkutpRcU=6Og@mail.gmail.com>
 <ameQUN3zlD0Ei8Jm@pie>
 <CAH22mJyMqTgRLqyfVZGgSHHNK7XnBTnrkY-R1ix5DN+oiBDEbg@mail.gmail.com>
 <amhyAULw9Wovuo3z@pie>
In-Reply-To: <amhyAULw9Wovuo3z@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 22:05:14 +0800
X-Gm-Features: AUfX_myratUIMNxziYDUDPYas-IAQ6Q95tOa9o7aAndXzXSN0Y1sJzBTTZYZErk
Message-ID: <CAH22mJyyExBuUrDNgRg=WU4f6RkN7M0QhtuUAgXiUf8b84TaCQ@mail.gmail.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785333928; x=1785938728;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sJU+ROxdo33pkj4AWYehaglBmU5NkMALTJSYmgHTMGI=;
 b=YjCQ2v5xRQ1E7zu4s6BtpEHTz1l+VaJkOcvqYsvsJKLY9ZemxTGqA0MEsaYxz/flB1
 Gr4DkOIV/Zbtmks0H2MJmcLGbVabTog/i9PC4NXaiokMzaSq3QnXHJAhE+2F6wGcS+o5
 UV+aN6rRVDtWRGy1DjjytN0+2x2UwSccbNZTtb8pd3hCmHEWKg1zBquh2zPnzA6JPwpy
 XPUlayCc5gamzYDMefmjYrXEmUIna8FAoOk8LtXTsUmsLHMqZ1XC6jQi+MWPU28+x0ng
 VHHuQhP09k6ACBRdhfLonNUMS4KRB2Xz1NrdTObmYXl8EITVfDQbFUbWGwOpIMOCvj50
 Ijzg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=YjCQ2v5x
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

On Tue, Jul 28, 2026 at 5:11=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
>
> On Tue, Jul 28, 2026 at 09:04:52AM +0800, Eric Chung wrote:
> > On Tue, Jul 28, 2026 at 1:08=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
> > >
> > > On Mon, Jul 27, 2026 at 09:08:52PM +0800, Eric Chung wrote:
> > > > Hi Yao,
> > > >
> > > > I'm not familiar with the policy for syncing DTS files from the Lin=
ux upstream.
> > > > Could you clarify how this script works?
> > > >
> > > > Does it sync all DTS files from Linux upstream at once, or is it
> > > > possible to sync
> > > > only the Spacemit DTS file?
> > >
> > > update-subtree.sh cherry-picks a commit from the upstream, or
> > > merge an upstream tag into the subtree. Cherry-picking SD-related
> > > commits from Linux upstream suits for your case.
> > >
> > > > If I choose to sync only the Spacemit DTS file and include it in my=
 patch set,
> > > > would that cause conflicts later when others try to sync all DTS fi=
les?
> > >
> > > Tom synchronizes the dts subtree with Linux upstream irregularly, the=
re
> > > should be no conflict or relatively small ones if you cherry-pick the
> > > changes, while adding downstream nodes in *-u-boot.dtsi might suffer
> > > from duplication, too, during synchronization.
> > >
> >
> > The process is a bit complex. Since my main issue is that the DTS
> > files are out of
> > date, would it be simpler if I just copy the relevant Spacemit DTS
> > files directly
> > from the Linux upstream into the dts/upstream folder?
>
> The answer is simply no.
>

OK. I'll keep using my own overlay DTS file.
I tried upstream DTS file. It only gave me more bugs. I could switch to
upstream DTS file when Tom syncs it.

> > > > Best Regards
> > > > Eric
>
> Regards,
> Yao Zi
>
> > > By the way, please avoid top-posting if possible.
> > >
> > > Thanks,
> > > Yao Zi
> > >
> > > > On Mon, Jul 27, 2026 at 7:52=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
> > > > >
> > > > > On Mon, Jul 27, 2026 at 02:59:08PM +0800, Eric Chung wrote:
> > > > > > Add the SDH0 controller node and its pinctrl groups to the u-bo=
ot
> > > > > > overlay. The upstream DTS only contains the eMMC node; the SD c=
ard
> > > > > > controller (sdhci@d4280000) and its MMC1 pinctrl configuration =
are
> > > > > > missing. Place the new node inside the storage-bus via path-bas=
ed
> > > > > > merge so it inherits the dma-ranges from the parent bus.
> > > > > >
> > > > > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > > > >
> > > > > Please cherry-pick upstream devicetree changes from Linux upstrea=
m with
> > > > > tools/update-subtree.sh instead of adding our own copies. Changes=
 for
> > > > > k1-bananapi-f3 and k1-muse-pi-pro have both landed in Linux v7.2.
> > > > >
> > > > > Best regards,
> > > > > Yao Zi
> > > > >
> > > > > > ---
> > > > > > v5:
> > > > > > - Append power source field on eMMC/SD pinctrl.
> > > > > > v3:
> > > > > > - Fix SD pinctrl as uhs.
> > > > > > v2:
> > > > > > - Use vmmc-supply as vqmmc-supply on SD node.
> > > > > > - Add alias of mmc0 and mmc1.
> > > > > > ---
> > > > > >  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 91 +++++++++++++++=
+++++++++++++++-
> > > > > >  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 86 +++++++++++++++=
+++++++++++++-
> > > > > >  2 files changed, 173 insertions(+), 4 deletions(-)
