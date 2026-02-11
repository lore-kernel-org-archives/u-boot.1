Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7D1ECD6C7
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 16:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857AA8352B;
	Wed, 11 Feb 2026 17:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hKTvBJok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C97683B64; Wed, 11 Feb 2026 16:25:52 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1FB48388D
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64adabaafd6so2175449d50.0
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 07:25:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770823548; cv=none;
 d=google.com; s=arc-20240605;
 b=GryT5m5jVmuhL3VovEfopju3r0cXakCBvbK6n+kE4O0D7etfNjCsTzj+ccUcqYuHpA
 W+yLsqdmcrgAiC+pSt1MbP7gBwLYUzQOOT65/QtdtGkq1KTeCY3XXcYzGyoe0SHYIl0X
 V4aBz4DaaDYywJ6N9rvzkM/gxNWa/Xw029z8B7Q3m9p9YtQuvgyejZ2WyWhoQjnIH3p5
 oVa5Cv1MfIebbBH+GbTHvIdhAgFp+KsyyE6IVsPZvDw2gqeVuYBLR0yD0HGv3b7SC5Tb
 53i6HqlXPA1MFYOf3h/l49UEwTE5QgXQORjHOWHk5vxk5cU3FSXiqAZ3Qzf/+0Y/5ukK
 qRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uh8Z6xq+N3JNjLQaf1tVb5bkWXgLOfwkYX/F3AaIzas=;
 fh=zn9mClUhLogeThVR0x9EF3xRJ6oasiwcTwIAwzdvidc=;
 b=AoAa18fdMDmvEoMVn/Iuk5YyiDa2+jvgYMUueRnwgVwRyItxRKx00FcCaSiQKpFqjk
 wsezP2GR3F7gmtXfGovm3Mbk+gb2E9IEtpTks08j8qlvP4CwEcCMqE08bbdee8UswQen
 FqR/14e5vTLFN3EFIUjb91FrZkSakAzElFzyhWJi9mqXLTxN6x7K7vIBOihXy9xVzqiw
 nTAywd5p1V/CvItn/8xN9WiyZcvplTdyzCy7c9G8DRAYbu6NVMZzZsTIdPXIQgjt2dZ/
 fDaOnhtdIr9E4hNWx2L0I2hfWtVURDGvT8TgmOYb6YIuf3jFe+/vg2gtbJvEMhTVKU0J
 Pr2g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770823548; x=1771428348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uh8Z6xq+N3JNjLQaf1tVb5bkWXgLOfwkYX/F3AaIzas=;
 b=hKTvBJok6Avwg3mfoMx44pC3/58ILVgzoxo0BuwbmkT1Dwrc39rqxlfLWaM/L7NYJ3
 4awxe3e2sC3vLZHLsuyIhSfrfr9pTYVfH954/6+NLKjIaM6Zxji4cb1EOeFbwV5O7Ob/
 9nuv/9C8h5foNdErNJvZxfZHE/JCcsSV3mMG5fWsGfaVnL3dcNoxgd9Ee1ms3ksenhhi
 MZRvvDugiyjdXe575rJLbyn5jUfYB9xFmCoHxZMzCBmexcliuT+oFnuAGGzsGZkTcGl7
 StoCI24yr+oKKJZ13DLy2kBvJ/O6knviwYWQhCOvxCBArrTecwrB1kYIAXYLRgzUan9z
 10uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770823548; x=1771428348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uh8Z6xq+N3JNjLQaf1tVb5bkWXgLOfwkYX/F3AaIzas=;
 b=LM2e/2oDi24QUwp/PpBstXxO2/K+TEyk7NNYfqzRtlGq3VfFQKy/SOcbiipQPIiWt1
 4E2LifEAdaSXxEcTSwkQth0seXT3iL4Cb4T84OWTakNRmMUQQZHzSlzIqBYzwxK3LbNR
 UAAoykO/T4RIVYK94l/dF/WxXgQ7YMXFCwazK5g2xNonyM/tGwuICFEbDMIxrhjaR+kL
 JpNDSpeW+jbbuBiE1Ad7OFAMqoPe7CiCdWXXNJ/M2U267FnqKlaCe9JU+/xr0xh7AAva
 X8U/ozrzNR5mEpTcVoAdn9IrtleEfXB9aFtPvS2Ws3J2USNu6F8SPQlf1PemnNKzxlAt
 KjsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWda5+Z2bCUnqUEttGBnGt/7Y8kctk5xFjSjQMNstFqQ6ALnY7918/+sHltgQLP1JQilUAmd9U=@lists.denx.de
X-Gm-Message-State: AOJu0YwvOGKSZnU8//UCIL4IIglgSHqYuDq3Qp6Aq+8x2VjGEqOmjq9K
 CZoOOPwBS2uFUYPSWkfd1SDtWl8mWlLpf6afHai87j3pxbLuNfd5CvTZLygPaJCYLddtSQohtRg
 WQPAI7SrRy34xmE8Ku5S3z/0yAPvkmEj+qVOkmkW8NQ==
X-Gm-Gg: AZuq6aJOv7uEG1DsQw1MZogQCQkHunb5fPfoeAcDUDaL1rR6g3+87tuSmmbnkCXjyKp
 vAeA9NfeqKT6CG1c2WY1wXMfmKIw8aWVnvuWG4VkCPsq0JL7+srWUV/pq+UrD06v+sTxvhstBRs
 IwQ/CYPMJuYbGWCYJQYPyoRxeuPNoMvJaVYdMBZXWs6gP4zsZs4EuEJiMXOiAcqvg60Gx4/vhOF
 hsXpgj9vRtqnXcVKI4T+/Fjca2IQMgr/wkUJtOTBp/sFrBcH1KfTXcnU3RXgf5QFYQhRmG9NJPA
 DtKZbtj0oRzChAfXFQRBnU4KEHGIrgZyfF44WaQLY/6CddzZLSwk+XKuRX+B+j3t/kuk7I+8L1s
 wP5Z4SjZvQedzS1ewgyWvQquWACR/XPI9YWLDAkb1fktaFm9E3hKLOKqkuaytrakr8dlvYTFfC6
 brdk5IilzigQgv/dNee/QWhLYfv9iyXAW04XrsAFsLhZDFJ/XgUviW7Ad/Tm3hAmybiqze8hgCn
 2/mToPVyMDSd5v1Urg0RtUS1sTb5Rmvvx7iIh2c/wwmmGw8mLctgmAnuObpup7vVL2qhmk2gvA+
 AV/4B0oFG0nEp9JkwsVsrC4Pzozd4XLBDDdlOImP+LcO
X-Received: by 2002:a53:e192:0:b0:648:3d3:790a with SMTP id
 956f58d0204a3-649f1e66bdcmr12473217d50.17.1770823548390; Wed, 11 Feb 2026
 07:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20251216091632.512635-1-ilias.apalodimas@linaro.org>
 <0205a2e4-0ccb-4dd0-b901-cc6afae31189@kontron.de>
In-Reply-To: <0205a2e4-0ccb-4dd0-b901-cc6afae31189@kontron.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 17:25:12 +0200
X-Gm-Features: AZwV_QgQlyTz_ogQiiio-apkiGLei5axt-f-IFw_IQaNkTgN7mVZwyuwmhxptbM
Message-ID: <CAC_iWjJLm98Vm70xxLAY=aAvSzb7eq2hRhrqUdr1sLZNUZj0iA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Bump the build system to 6.1
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: trini@konsulko.com, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, "Andrew F. Davis" <afd@ti.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Michal Simek <michal.simek@amd.com>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 E Shattow <e@freeshell.de>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Sam Edwards <cfsworks@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>, Philip Molloy <philip.molloy@analog.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Greg Malysa <malysagreg@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Raymond Mao <raymondmaoca@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 11 Feb 2026 17:55:10 +0100
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

Hi Frieder

On Wed, 11 Feb 2026 at 15:35, Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 16.12.25 10:16, Ilias Apalodimas wrote:
> > From: Sughosh Ganu <sughosh.ganu@linaro.org>
> >
> > Our last sync with the kernel was 5.1.
> >
> > We are so out of sync now, that tracking the patches and backporting
> > them one by one makes little sense and it's going to take ages.
> >
> > This is an attempt to sync up Makefiles to 6.1.
> > Unfortunately due to sheer amount of patches this is not easy to review,
> > but that's what we decided during a community call for the bump to 5.1,
> > so we are following the same guidelines here.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>a #rebased on -next
>
> To me, it looks like this is breaking "make cross_tools" in some way. Or
> am I missing something?
>
> With v2026.04-rc2:
>
> > make tools-only_defconfig
> > make cross_tools
>   UPD     include/generated/timestamp_autogenerated.h
>   PYMOD   rebuild
> tools/Makefile:359: *** insufficient number of arguments (1) to function
> 'filter'.  Stop.
> make: *** [Makefile:2191: tools] Error 2

Does the below fix it ?
diff --git a/tools/Makefile b/tools/Makefile
index 0ac683ac3ec7..c4308304d99a 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -356,9 +356,9 @@ override HOSTCFLAGS = $(CFLAGS)

 quiet_cmd_crosstools_strip = STRIP   $^
       cmd_crosstools_strip = $(STRIP) $^; touch $@
-$(obj)/.strip: $(call objectify,$(filter $(hostprogs-always-y)))
+$(obj)/.strip: $(call objectify,$(filter $(always),$(hostprogs-y)))
        $(call cmd,crosstools_strip)

-always-y += .strip
+always += .strip
 endif
 clean-files += .strip

Thanks
/Ilias
>
> If the problem is not on my end, then I would have assumed the CI would
> be able to catch it. But "make cross_tools" is not part of any test, right?
>
> Best regards
> Frieder
