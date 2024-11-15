Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44522D68BD7
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 21:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C42896DA;
	Fri, 15 Nov 2024 22:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P/qsEuA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3226489294; Fri, 15 Nov 2024 22:35:34 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4CA6896DA
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 22:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-382296631f1so592493f8f.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 13:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731706531; x=1732311331; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbtfA6R0QaJLa0mSJupv/SLDFayiU8abogBDjkuOvrQ=;
 b=P/qsEuA7BlVAlrxI2jOc8Pf+JmhxiCpbDXLBHdtivmUut+n9FLd2pL0m/tc4/eYu1d
 32IPhDshNirMjXvNU7Q28KjDVbjFdOzVOITJazH+psLOCOWfleVI5RQU93QtO604AR09
 dWcUtV5mmEulUl1kkj19gYHOPLQX22r4lfLkz54gFXxn0I07KmzSfCdo2BHfQHyz2DKc
 UMGy2Fs6IjLa0ZoaZhnEN6yfrZ2/ekL3Sg7W2gcHTMDxsVu2/eCYVLRfltD72etbjsj+
 cJ5EtlOoS0UCZPwbO4LxfTtxfUU+QtSQaFQcUZbLiwGxek2YfXcv+Xu6rsMsNVT4AFe3
 Wa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731706531; x=1732311331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbtfA6R0QaJLa0mSJupv/SLDFayiU8abogBDjkuOvrQ=;
 b=TjuiOSm/6ALaLLvL1719Kby95ryrhwnxA8HVhqKWfL0U1Oo1RpNH9oJT9Y9ZMAUzcx
 exiYS6+r/zSDGgEGz+MwW8AZ12Rp79uX5RSoFid6MnX/cXVAOeQppreu7HWIKnYMHSQ6
 BAnDY207xWb1+/q8lbhGNI2OpNLhT8YhXVpXS/s+t8hByvLwLTdvJwD+BRmUA4YLes/g
 MnB4j6lpD89eNaQnZUhnIDPyQ33wtNb2+9mSYl+78YzPyJezX8us/nnlU2DF8kgNCdQI
 LQNbJFpJ/TZwz3rpvBzsaFMsjrrqa2oTlzoVI32MwAf8aoOJ9xH8clT+38HtI9+zLJ2I
 PV4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqs5CHJhxEQ9fKbgs7taE/KL/+nHD6BnN5XSUzg8tU9YrbVNFH+i609r8LTaQN+u8CVSVqMJs=@lists.denx.de
X-Gm-Message-State: AOJu0YzyUoTCYtCR+HJXX3bWJmwH2DcnLF9ebBSsobdMK0acTFysoY2+
 40crkRc0NA/2IuO1rTICXTstt1g9dlK6YvMqMUwDbIrTHtVGnH3QaSXx2W1FisG3U7TdokBo/F8
 6sjrtSx13lcK3TWdG8w5Xvayhdi4=
X-Google-Smtp-Source: AGHT+IHDuyFd9xAnAicPnqwjaS8/Q1fMGAmYbDk7FPAKbqPDj5GpClwh1JGQPZ01QUnrVRMupnlFKHGiL93P2WOJyVk=
X-Received: by 2002:a05:6000:714:b0:37d:5405:817b with SMTP id
 ffacd0b85a97d-3822590b819mr3795214f8f.7.1731706531127; Fri, 15 Nov 2024
 13:35:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
 <20241115141748.GS3600562@bill-the-cat>
 <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
 <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
 <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
In-Reply-To: <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 15 Nov 2024 13:35:19 -0800
Message-ID: <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
Subject: Re: Git commit failed with mbedtls/framework
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,
Hi Raymond,

On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Hi Tony
>
> On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com> wrote:
>>
>> Hi Tom,
>>
>> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <mibodhi@gmail.com> w=
rote:
>> >
>> > Hi Tom,
>> >
>> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
>> > >
>> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
>> > > > Hi Tom,
>> > > >
>> > > > I am on 2025.01-rc2, and I am trying to commit some files. The err=
or
>> > > > seems to indicate this framework directory might need some
>> > > > modification. Did I miss something?
>> > > >
>> > > > error: 'lib/mbedtls/external/mbedtls/framework' does not have a co=
mmit
>> > > > checked out
>> > > > fatal: updating files failed
>> > >
>> > > That's odd. You didn't happen to try out some of the previous lwIP
>> > > iterations on that tree did you?
>> >
>> > No, I did not. The tree is clean with "make mrproper" and on the
>> > master branch. I just did a git pull and worked on it.
>> >
>> > I went and looked at https://github.com/Mbed-TLS/mbedtls.git. The
>> > framework directory is pointing to a specific commit.
>> > framework @ 3867faa
>> >
>> > I'll stash and repeat it on another clean tree.
>>
>> I have the same commit error on a brand new tree.
>>
> I think you are talking about the test framework of MbedTLS's original te=
stsuite,
> am I right?
> MbedTLS was ported into U-Boot as a git subtree and that framework is a g=
it
> submodule of original MbedTLS repo which was not included in the porting
> of U-Boot since U-Boot has its own testsuite.

Here is what I found.

git clone https://github.com/u-boot/u-boot.git u-boot-master-test
cd /usr/src/u-boot-master-test/
patch -p1 < ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
git add .
git commit . -m "arm: kirkwood: Enable bootstd and remove jffs2 for
Sheevaplug board" -e

The git commit above gave out this error:

error: 'lib/mbedtls/external/mbedtls/framework' does not have a commit
checked out
fatal: updating files failed

So I tried to commit only the specific files, and it works OK.

git commit configs/sheevaplug_defconfig include/configs/sheevaplug.h
-m "arm: kirkwood: Enable bootstd and remove jffs2 for Sheevaplug
board" -e
[master 47de8cff2d] arm: kirkwood: Enable bootstd and remove jffs2 for
Sheevaplug board
 2 files changed, 17 insertions(+), 19 deletions(-)

I think it must be what Raymond said above. So perhaps during Tom's PR
pull, the framework directory was created. But "git commit ." does not
like the empty lib/mbedtls/external/mbedtls/framework directory.

Thanks,
Tony
