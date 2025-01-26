Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6663C02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 15:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A4A380F84;
	Sun, 26 Jan 2025 16:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rw7MuRvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5589B80F85; Sun, 26 Jan 2025 16:59:18 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A58480F84
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 16:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b8618be68bso362027885a.3
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737907154; x=1738511954; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WKlU3KGPMRb9Z4rBUiFU3BdGdqyJu5O31nb0Jdo5z5E=;
 b=rw7MuRvG6JyB8KpZdiXcJiNWyx50JAiCR7Wgf9azEymv9Bt77LGBQBOIVs2QfaUbH3
 vxcduAmMDjq8QjsUHCuBlU1Z7BXArXXe/Iu4cwSXbhqxQJbtKCB5ifxxvQ0eRArLRXzG
 JgkELWkRzvPhsR2gI9/2aYmPR3fkwxtIZZW0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737907154; x=1738511954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKlU3KGPMRb9Z4rBUiFU3BdGdqyJu5O31nb0Jdo5z5E=;
 b=fSmbQMLziOAhxuPVcoaSOzhCQXfr1tZWrcWiFsCaQ+30sn9/XqbnLNErmB0CcCoDxX
 vCj6WmwD4q9nOXy8hV4bt+VERkBpR/JKrsTPJI5GVsGfkyJd0+g7a+Z1CN8SyjnYikNX
 35xDmmxNh83QVnlbFz0h/lH9pTp6/dxfml7HcieZfvxpnvs9+tcsf9OUu3Soao8PenTC
 dC037umzKfhvrbyxT3qs3gucoUXmKQXoyzdUSOoYNqIhBXJRwL32t1RIT729/PvrzxEI
 kxSVjJmFtstTYtBi4p+7+65l8ahYI9uYaE48agjBuSso0KiH9LaQYjwpVH4ct+U/yxVT
 zA+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhENKnhotHPZM8NrJC52t//VDcV+qsci27lbXeSIjD0tS6p+BWJ5rGV1+0RbDN8lsLXpO+Kt4=@lists.denx.de
X-Gm-Message-State: AOJu0YzVCLnXtUH6MS7ooJWgXBbAi/MwpQN453EGR8U41njhMoZ3rEK9
 9x/HfVQt6jTYhT9A2tY1bPFepT9POuZlttDfuuvL6ec1ysKPgrP1FhzpN19yN74=
X-Gm-Gg: ASbGncv6m/nU9D3xD0vazl/XFCZ4Om8GUtwEGwjrfHXrf3DBbs19GgozL+2XwvTi+5o
 SizPqNTNM0D9SqpAeGx66uGTbBXCE1VJx1Or3/ljj57++7E5F8HgSHkQZZxy3NF2RtcVHJWhtMD
 +MhoJJe+Vc8hrKyEL4t7QH12JchqcyRb14/lGDB791OCacQ8v6JJQiP/DH2GVoOQw2UV39D5F+n
 hCqChK65Y+XgSqhxdZPPkjre3cQc7m2vk2eprfabNF1YqS3F7qqNEttzK8HIyKM1u9CvyiNh5PY
 lYLo
X-Google-Smtp-Source: AGHT+IHMh7oBBHlX8wEubrTsefLJqcXg7cBbPaEDM2CgnLeDemo7VNbqBR/FfdPqb3GSeo3yzojKXw==
X-Received: by 2002:a05:622a:134c:b0:467:6c95:19de with SMTP id
 d75a77b69052e-46e12a1e56amr632034291cf.11.1737907154244; 
 Sun, 26 Jan 2025 07:59:14 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66b6aa9fsm30850661cf.49.2025.01.26.07.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 07:59:13 -0800 (PST)
Date: Sun, 26 Jan 2025 09:59:09 -0600
From: Tom Rini <trini@konsulko.com>
To: ZHANG Yuntian <yt@radxa.com>
Cc: Tony Dinh <mibodhi@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Git commit failed with mbedtls/framework
Message-ID: <20250126155909.GA1233568@bill-the-cat>
References: <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
 <CAEfUkULhPuH15fDENXubhNPOQvbAjBv5f_yoeH7gjC4rhczxtA@mail.gmail.com>
 <20241118153742.GO3600562@bill-the-cat>
 <CAEfUkUJNOTCsh19VbKsHw9wWO1nn8o-OhRrAB46uhpKHO-Owsw@mail.gmail.com>
 <20241118164122.GQ3600562@bill-the-cat>
 <CAEfUkUJmSL8-XR6LUAKX=xW-mYQWNHzanRKvAVFaB2A9nA4W1A@mail.gmail.com>
 <20241118171811.GR3600562@bill-the-cat>
 <8823CB36AD9BEA6D+3c5f1842-bbaf-4dfa-96a6-d6d53b61ed10@radxa.com>
 <20250124182330.GQ60249@bill-the-cat>
 <8B2016527B9BCFBA+ca2da5a3-e889-4191-b951-88656d1043ab@radxa.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7YT+euLg359DPBGJ"
Content-Disposition: inline
In-Reply-To: <8B2016527B9BCFBA+ca2da5a3-e889-4191-b951-88656d1043ab@radxa.com>
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


--7YT+euLg359DPBGJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 03:13:46PM +0800, ZHANG Yuntian wrote:
> Hi Tom,
>=20
> On 2025/1/25 02:23, Tom Rini wrote:
> > On Fri, Jan 24, 2025 at 02:05:28PM +0800, ZHANG Yuntian wrote:
> > > Hi Tom,
> > >=20
> > > On 2024/11/19 01:18, Tom Rini wrote:
> > > > On Mon, Nov 18, 2024 at 12:16:18PM -0500, Raymond Mao wrote:
> > > > > Hi Tom,
> > > > >=20
> > > > > On Mon, 18 Nov 2024 at 11:41, Tom Rini <trini@konsulko.com> wrote:
> > > > >=20
> > > > > > On Mon, Nov 18, 2024 at 11:27:06AM -0500, Raymond Mao wrote:
> > > > > > > Hi Tom,
> > > > > > >=20
> > > > > > > On Mon, 18 Nov 2024 at 10:37, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > >=20
> > > > > > > > On Mon, Nov 18, 2024 at 10:24:32AM -0500, Raymond Mao wrote:
> > > > > > > > > Hi Tony,
> > > > > > > > >=20
> > > > > > > > > On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmail.co=
m> wrote:
> > > > > > > > >=20
> > > > > > > > > > Hi Raymond,
> > > > > > > > > >=20
> > > > > > > > > > On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Raymond Mao <
> > > > > > raymond.mao@linaro.org>
> > > > > > > > > > wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > Hi Tony and Tom,
> > > > > > > > > > >=20
> > > > > > > > > > > On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmai=
l.com>
> > > > > > wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao=
 <
> > > > > > raymond.mao@linaro.org
> > > > > > > > >=20
> > > > > > > > > > wrote:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Hi Tony
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@=
gmail.com>
> > > > > > > > wrote:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony D=
inh <
> > > > > > mibodhi@gmail.com>
> > > > > > > > > > wrote:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom R=
ini <
> > > > > > trini@konsulko.com>
> > > > > > > > > > wrote:
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, T=
ony Dinh
> > > > > > wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > I am on 2025.01-rc2, and I am trying to c=
ommit some
> > > > > > files.
> > > > > > > > The
> > > > > > > > > > error
> > > > > > > > > > > > > > > > > seems to indicate this framework director=
y might need
> > > > > > some
> > > > > > > > > > > > > > > > > modification. Did I miss something?
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > error: 'lib/mbedtls/external/mbedtls/fram=
ework' does
> > > > > > not
> > > > > > > > have
> > > > > > > > > > a commit
> > > > > > > > > > > > > > > > > checked out
> > > > > > > > > > > > > > > > > fatal: updating files failed
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > That's odd. You didn't happen to try out so=
me of the
> > > > > > previous
> > > > > > > > > > lwIP
> > > > > > > > > > > > > > > > iterations on that tree did you?
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > No, I did not. The tree is clean with "make m=
rproper" and
> > > > > > on
> > > > > > > > the
> > > > > > > > > > > > > > > master branch. I just did a git pull and work=
ed on it.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > I went and looked at
> > > > > > https://github.com/Mbed-TLS/mbedtls.git.
> > > > > > > > The
> > > > > > > > > > > > > > > framework directory is pointing to a specific=
 commit.
> > > > > > > > > > > > > > > framework @ 3867faa
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > I'll stash and repeat it on another clean tre=
e.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I have the same commit error on a brand new tre=
e.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > I think you are talking about the test framework =
of MbedTLS's
> > > > > > > > > > original testsuite,
> > > > > > > > > > > > > am I right?
> > > > > > > > > > > > > MbedTLS was ported into U-Boot as a git subtree a=
nd that
> > > > > > > > framework is
> > > > > > > > > > a git
> > > > > > > > > > > > > submodule of original MbedTLS repo which was not =
included in
> > > > > > the
> > > > > > > > > > porting
> > > > > > > > > > > > > of U-Boot since U-Boot has its own testsuite.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Here is what I found.
> > > > > > > > > > > >=20
> > > > > > > > > > > > git clone https://github.com/u-boot/u-boot.git
> > > > > > u-boot-master-test
> > > > > > > > > > > > cd /usr/src/u-boot-master-test/
> > > > > > > > > > > > patch -p1 <
> > > > > > > > ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
> > > > > > > > > > > > git add .
> > > > > > > > > > > > git commit . -m "arm: kirkwood: Enable bootstd and =
remove jffs2
> > > > > > for
> > > > > > > > > > > > Sheevaplug board" -e
> > > > > > > > > > > >=20
> > > > > > > > > > > > The git commit above gave out this error:
> > > > > > > > > > > >=20
> > > > > > > > > > > > error: 'lib/mbedtls/external/mbedtls/framework' doe=
s not have a
> > > > > > > > commit
> > > > > > > > > > > > checked out
> > > > > > > > > > > > fatal: updating files failed
> > > > > > > > > > > >=20
> > > > > > > > > > > > So I tried to commit only the specific files, and i=
t works OK.
> > > > > > > > > > > >=20
> > > > > > > > > > > > git commit configs/sheevaplug_defconfig
> > > > > > include/configs/sheevaplug.h
> > > > > > > > > > > > -m "arm: kirkwood: Enable bootstd and remove jffs2 =
for
> > > > > > Sheevaplug
> > > > > > > > > > > > board" -e
> > > > > > > > > > > > [master 47de8cff2d] arm: kirkwood: Enable bootstd a=
nd remove
> > > > > > jffs2
> > > > > > > > for
> > > > > > > > > > > > Sheevaplug board
> > > > > > > > > > > >    2 files changed, 17 insertions(+), 19 deletions(=
-)
> > > > > > > > > > > >=20
> > > > > > > > > > > > I think it must be what Raymond said above. So perh=
aps during
> > > > > > Tom's
> > > > > > > > PR
> > > > > > > > > > > > pull, the framework directory was created. But "git=
 commit ."
> > > > > > does
> > > > > > > > not
> > > > > > > > > > > > like the empty lib/mbedtls/external/mbedtls/framewo=
rk directory.
> > > > > > > > > > > >=20
> > > > > > > > > > > Under the native MbedTLS git repo, by default it has a
> > > > > > "framework"
> > > > > > > > > > pointing to
> > > > > > > > > > > its git submodule.
> > > > > > > > > > > Maybe we should mark it in the gitignore.
> > > > > > > > > >=20
> > > > > > > > > > I've tried .gitignore but could not make it work (my Gi=
tfu is
> > > > > > pretty
> > > > > > > > > > lousy). Can you suggest how that should be done?
> > > > > > > > > >=20
> > > > > > > > > > You can use the command without the '.' : git commit -m
> > > > > > "<commit_msg>",
> > > > > > > > > this
> > > > > > > > > should work.
> > > > > > > > >=20
> > > > > > > > > @Tom Rini <trini@konsulko.com> Shall we remove both
> > > > > > > > > "lib/mbedtls/external/mbedtls/.gitmodules" and
> > > > > > > > > "lib/mbedtls/external/mbedtls/framework"? I can submit a =
patch if you
> > > > > > > > agree.
> > > > > > > >=20
> > > > > > > > Can we do that and not make a problem for the next resync?
> > > > > > > >=20
> > > > > > > > Hmmm, no, this cannot be pulled back to the MbedTLS upstrea=
m so still a
> > > > > > > problem
> > > > > > > when resync.
> > > > > > > Another option is to include that git submodule into the U-Bo=
ot project,
> > > > > > > this needs
> > > > > > > to revert the commit of introducing the library and redo the =
git subtree
> > > > > > > after the
> > > > > > > submodule is updated, but it does not seem to be a good choic=
e as we
> > > > > > don't
> > > > > > > use
> > > > > > > that test framework in U-Boot at all.
> > > > > > > Right now I don't have a perfect solution, maybe we can accep=
t using git
> > > > > > > commit
> > > > > > > without the '.'?
> > > > > >=20
> > > > > > Hmm. Maybe we just delete the .gitmodules / directory and it sh=
ouldn't
> > > > > > be too hard to deal with on updates. I have to do some small fi=
xups with
> > > > > > the device tree ones anyhow sometimes.
> > > > > >=20
> > > > > > How about checking and deleting this in the subtree update scri=
pt?
> > > > > Then we can skip manually doing this each time.
> > > > > I can make a patch for it if you feel fine.
> > > >=20
> > > > Lets worry about that if it's a problem when we resync next.
> > >=20
> > > I'm currently working with Jonas Karlman's Rockchip fork[1] which is =
based
> > > on a416d9e680718de1c76c4196e1db77e3ca07662f. The fork is included as =
a git
> > > submodule so we can provide distro packaging[2] that are unrelated to
> > > U-Boot. We build our package with GitHub Action, and this issue curre=
ntly
> > > blocks us from checking out the code at all with the following workfl=
ow
> > > snippet:
> > >=20
> > >        - name: Checkout
> > >          uses: actions/checkout@v4
> > >          with:
> > >            submodules: recursive
> > >=20
> > > Related error logs are here:
> > >=20
> > > |> Fetching submodules
> > >    /usr/bin/git submodule sync --recursive
> > >    /usr/bin/git -c protocol.version=3D2 submodule update --init --for=
ce
> > > --recursive
> > >    Submodule 'src/rkbin' (https://github.com/rockchip-linux/rkbin.git)
> > > registered for path 'src/rkbin'
> > >    Submodule 'src/u-boot' (https://github.com/Kwiboo/u-boot-rockchip.=
git)
> > > registered for path 'src/u-boot'
> > >    Cloning into '/home/runner/work/u-boot-kwiboo/u-boot-kwiboo/src/rk=
bin'...
> > >    Cloning into '/home/runner/work/u-boot-kwiboo/u-boot-kwiboo/src/u-=
boot'...
> > >    Submodule path 'src/rkbin': checked out
> > > '0f8ac860f0479da56a1decae207ddc99e289f2e2'
> > >    Submodule path 'src/u-boot': checked out
> > > 'f3231571f4f9c3f72dcb6458aaa2de2462c605df'
> > >    Error: fatal: No url found for submodule path
> > > 'src/u-boot/lib/mbedtls/external/mbedtls/framework' in .gitmodules
> > >    Error: fatal: Failed to recurse into submodule path 'src/u-boot'
> > >    Error: The process '/usr/bin/git' failed with exit code 128
> > >=20
> > > This issue potentially breaks all projects who include the recent U-B=
oot as
> > > a git submodule in their GitHub Workflow.
> > >=20
> > > 1: https://github.com/Kwiboo/u-boot-rockchip/tree/rk3528-2025.04-wip
> > > 2: https://github.com/radxa-pkg/u-boot-kwiboo/actions
> >=20
> > What if instead of "submodules: recursive" you use a run statement?
> > https://github.com/marketplace/actions/checkout-submodules
> >=20
>=20
> We can certainly work around it in many different ways. But the point is
> that U-Boot is currently a broken repository in regard to git submodule
> operations, and require special treatments to integrate with existing
> pipelines. This was not the case before.

Unfortunately if I recall things correctly there's not a good way for us
to solve the problem in our tree since bringing in the problematic
submodule via subtree just grows our codebase with things we don't use.

Perhaps you could provide a patch to doc/build/source.rst with an
example of how you're working around the problem so that it's easier for
others when they run in to this problem? Thanks!

--=20
Tom

--7YT+euLg359DPBGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeWW80ACgkQFHw5/5Y0
tyxDdwv/cOY1gn775sJTi7UiXCF8rpZgyPV7dcsNZ+p40xsOV2nZHaILpPr9TFDH
VqCLljhjte6Ig4Wz6evtZbmdEJCUd4YKGxxOvvWXyx/k6UAGfXYQ0luMRUvdcLWv
cBtyUA/tWNr0l1Dpmk28N9APefJuXo9t1CX+o0SjeR9RuZq07sir/hwXQGf5+3rX
p+kYLDBJOWLWkn8AHSdZO93Hc/KA9+VG+YAg6ZFbhkf4VUWUa6GMxl8tbBC0mN1s
ZfeX1v2dp7G49Eh55WhVfv5mkjv52OU1g1wDoByEQCCDjrFRfz1CC8lF/48pws7i
FQZT+QbwxIakk0cr19JsG4Zc+zGd3iJqLlKiNCLU8UHYfpISjEptJFJjC2ZwSFcF
eZfTvOaXZwgO2mCmU0GOTMHnCUu5583Qp6z9x/K5Gws4Rqq5dmzfUcAP4iChxW5Q
fekNsesrHD83Z+ib3VoewmO7eTf5r69iL/5Hbj+R/tmYIdGD5chJ0AEVXO/NaqOo
0CD76m6G
=Kz0a
-----END PGP SIGNATURE-----

--7YT+euLg359DPBGJ--
