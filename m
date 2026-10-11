Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513D7CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 17:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2742A406E8;
	Sun, 11 Oct 2026 17:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w519xkDS7lEe; Sun, 11 Oct 2026 17:23:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 095664065F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791739396;
	b=AHjkzaOI3lz0184XQ4ZiHNFCN7JovT4fo890azesYFdVObY/CDOS0SXx6Ki2sxiXFdbu
	 rrgfi1P8ZhEM2/laU5JBJKG7JUdwZS6LVwebIRyuNAa8MDcXR5Oc1jMddTk8/fGpQIFSq
	 Yy3jyv7sMot0LnsvUYkiS8F4E76nJEIktMFFK3MIjk2AQETAYp/Xr575KSBU8UFHnrASP
	 rb7CtK5yPzuD1msTxuP65x/WtbOWHS23qmlWjNACAh25h9x5pPbivesMYp1RqTf72Wq7I
	 1A/kKFWddxZZUnhthJGVdujODM5fwW8xVLXtDnHaTBG6dWFOUNFrNHWv69PlaJQcDXw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791739396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F2G7XJTQ61/lPTUBL345NnNP56R/14ivD+BrZgQUlhU=;
	b=aLtibKfW3Y5jMEiBa+ZxCTjzbFSGqaaJMoQ1KFTEFN7zxOaHMQGZczMNgXetacQEIomZ
	 dI1Gip4ZV/mCtgVv7FHgjbRk9R9EsTLulzEAFBc8VGuVrNn53EOu9tx6HSNQke3r7gmTq
	 ac4cY8GJJv6wGWgvn/7oR+F8/5i3pCyO+cPYagZnLx63sKShA0VS0UzkApxlL9xQm7qeC
	 R2YlPqH9KP4OlVhv0q4vhAfyYI14Hetc9ugFO9+cPO6LxUk6DKiRgr8saLqCGjLD98idY
	 0rhN3MZN7/AxfOD9hP85l8ZZsyfzy913wf01GzJJQIu1P6HmsD0bE2H6FCMcOHsnDkQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UphyF7uW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791739396;
	bh=F2G7XJTQ61/lPTUBL345NnNP56R/14ivD+BrZgQUlhU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=INr2a9x0ULNq4d20GA10032tPBTIXWbI5wuX/JnvoHWuH4t24dJd4T2IOqs2kC7E5
	 4oMl3GvCTXfktqg0km4dzXkcBCgyZVCCq0qGBLe8A34PqAn/Qm5K247AdSjZQ32KWC
	 aWj6L1KTsSOFkX6YYMyE6gy0YtXYa7eeNpa+kVwGdcm7NDMPg6TvXJm3a1xFNrhRNV
	 rzdLyTy7ccB0PPH/U4McaEfWo3R4RHbffCZhhxpUXZyd/tfOdpTLME/mfoR/a3QYDu
	 iy9QBYQLiQ19SeetxL/FbfQ3lkADhqgA493K4EsfwHf8a6j6imytae43varOsWZkm9
	 rELLUG8WCxOYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 095664065F;
	Sun, 11 Oct 2026 17:23:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3A51194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8850B4061E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cpAgjsMLTr0C for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 15:33:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2705140619
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791732838;
 b=JuN56XSoZ8fP/VNasX6cNDTLBBosBhvEM0yOv4/bNAzamfz/ogHRJdvuaEMn7Rgv/ZZi
 hEmUnWcGSiqA/H/iSBPO33aREGCV7SPXyMjQpsWT+PWQfn7DNbiKl3kvDiwgTxsYa6CA8
 HRz6xyWeAGq120knav3cDX9hbygZB4tVGeq9sw9kzYb+7ffdSkP7FMuvrNzbozZdVwskX
 zRuKUMsDH7lXb5A/MMX270gSic6cdoDexkqGjPJkn7cxCeLk53TbUqLODVYsSlWktuyej
 bXD0+t/NuHweBP7LDRkt+imQ0Jn4jKBMG9HDniz0OzxAZjnp2FWOPdSSh2vpHdLM4Pw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791732838;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=F2G7XJTQ61/lPTUBL345NnNP56R/14ivD+BrZgQUlhU=;
 b=VNUgD0xNGAQRyWbeBVPLTWsnWKZm0WKZUTBI6WpqF07B82Kmenx3pr7k1+IwMLlhWI9Z
 YQ9XEps3bKLj+E5+pJZzkc/8q3Fiu1CPN9MoqqmjmzyvHwTwpZMO9mqUmV7L+Edfhxbgt
 3WvVhJNqT5iY9OhssQvarCOtNPGVLOtwUyWla7sbyaOV6D4jK31t/or6ziwP68FUtN1/P
 nSDs1dyl7w+OPCk7nG2kGFqh1Cwi9wB1vaEobplWHShIFTGMRrMW7MjCqvOBQkyuBDeyb
 UOWbJq4ShgVfCxXZQO33jjr/Nn376lbzFlP5ADIH75PrGUxuFSgdOJllKsHQY3Kbgyg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UphyF7uW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UphyF7uW
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2705140619
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:33:57 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6afb0d2a586so2079166a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791732836; cv=none;
 d=google.com; s=arc-20260327;
 b=sdw2qJ/7ofc27ATnDp5KhkJYj2YsppZciIFtVxuYzseDKTGlLVDhV5FtxHNB5JwpjD
 4sMJCbqF0SFUKvHPIAszrJ64c4TUPYzL6SBeI/qyjzAay1WAkqC+HZvyw2qSIObV09Uq
 BKpuIHdcC59fyT7GesLibhE9UWOglYM1GW9AiVK+8hk1FBSiYZbh1gbQbi52iv5ZZSFs
 XMJ5tYV/pREAG5LNwwUotQv/Ns1QUt8wmK4+1q5G4wCB+wrsN9heFqy6gg++IpLsPDth
 EyE2gatxLPCHCjKGCcokGRegNzk1tmoLBMvRZjPvn4L4oJwyzvWzLaVE6jCXcu7N5STo
 tFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F2G7XJTQ61/lPTUBL345NnNP56R/14ivD+BrZgQUlhU=;
 fh=hbdeLsbrAeM8xjyDzJ222Y+RsNv/OP12GvN/Vv5HM8A=;
 b=N0DBhFJC7xhzWuJbAE89WUstEVX0GGMaO9aNTQFZQm5Z+NAocv43qvIHQuAfrXmQ+c
 ERvB2xcgRLFE/sFxequOIGhtsKgKTDnH8YCQ2h6cYWSEvLMTWFA5FLzR5PTbTvLvNi6c
 RjgBbZKL1wqvzmlAiQdTjLIb+X7lxmxSUD4ZlTqC5Yv9hb5puaVnvVFaVMzLSs7Mbz9A
 XqM/Jm7njQUFQthOFEsP4HpHQfjgh9hr29ASWdwEgbFXECe7k5wJZA4b3upa8/lHBEiH
 E8Oi2Z+ZbuORwlOy7fWZoFN17dACWMvaXcBf216QlcolIHu7PWb6eQt4JcU59FwWPnsV
 so3g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791732836; x=1792337636;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F2G7XJTQ61/lPTUBL345NnNP56R/14ivD+BrZgQUlhU=;
 b=UphyF7uWp2Fe2zhKHA8fb1F9/87VaxEF8X/WEWmdi1D/5fEMAVLMhJo7q9iqxoP6gp
 dXw3g2OetcI7t8WZSR+akcssZkIVAWPQzj4YGt1YglKkOGd3hDlqn93kjoMfONFOlEOs
 eeNU/cviWFjSdoINdiDKD4mlM8bJMrBMF0zaVuhOCjdCdV5Muy0/WTjWnN6QOi4VGNNt
 dd87qWr/XU9NljEZ5DIjp8qeKeYAlv2HF7yu7T54AKfOSidYxXWaa1v/nX5xQh1+PZ84
 Z5uF+qlRDFgTkvebruNdgdO5Em6t8/rsFOj6jOtJS1BEoAdrWXIo5tawExwoFG++TMmY
 +5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791732836; x=1792337636;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F2G7XJTQ61/lPTUBL345NnNP56R/14ivD+BrZgQUlhU=;
 b=ytrUps5UXy07W8y/Jx2lIIjYojS9Wb1QRcrodSkca/jUB0uV4dFGOYwJRx5IzmyNyB
 2zIiC9zaB38o4diiO4ijDWw6qiAiGkjcDbsNYOxPFVaKGWm6zkC1XEwXYDLdH/ADVy4w
 gwmk+ZYZm3ZI1htG/2WzkIcH2CozVE66tFH3S7jPoKfEa56GhgNTv6JNiZy4i49aa2Nc
 OeeQ6kckW3mQtZGM+W0ywkFYlMjsM3l5jMvwH8Um77MKG2K6UEYDCF7v4PjVYi4WT4Ld
 q87+mPawOcfE1rY9McNYc14YcyYqsb4VwYu5jzfMQtmnHK51JtNCGD2cJFMooj63F58E
 249g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwO9bGps8gVnLKe4Qg4MSk/Fq8onk8gxqyZgC5IvZul3LXSrs680aFPYXkGFC27Mg3l/+PX4FY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJpwd1R+Wh9grC29i2RtT2bDoXInPUCf6xHS2FFgHRt1zBDNIA1
 BpUR+wLoJYQgRY1oCZP59yFrSyntCTdFiu4ILfm0PTAq4boxyQ7M2SfxuzjLFTx1YqB6gqPf62a
 ik1cEQJOzHpCP4w2l+0VpC3sClioVrV8=
X-Gm-Gg: AYBFou0LVWcXm6hYV7vRhk/tc91Gpv3VZhx1kROokHL+Afv4KjN0Kul4PM3DNhWp2i0
 91/fTqdS3PmZPH/O2GximqXhQrT8IunRuf74BgqG7hGyP6j40bRKnP8KeCco5RqqIPImIpH/3L9
 CrIpLwK0hR7PkulRL2dA3warD3yjUcMrx+lc4RJI9nwsfC/kn50BjKGtwfAcWd0W5X5kxIX2CFN
 /y75Sk+/kzDTE2gDk6APIYYCnhDoutADuyDvY0O20kpEIN5EM9/5rKhJyU6CQsnK1w2AV4Lqmgj
 K2lIbruk5uTkqy1J4WvYUCeXZGwkkr+IwqkzAwvHkWvzYYzK/u0m5yZ8E3C8fEAS
X-Received: by 2002:a05:6402:21d4:b0:6b1:c697:3c46 with SMTP id
 4fb4d7f45d1cf-6b1c6973ee2mr128493a12.1.1791732835346; Sun, 11 Oct 2026
 08:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
In-Reply-To: <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 11 Oct 2026 21:03:39 +0530
X-Gm-Features: AclHuK8qzjx8sXcyDOvN5urLGg5AH1VGOOFDnSvyGnKgVIXgFO2S1styndSTWmQ
Message-ID: <CANAwSgQ2LqXxjn73OYt_jZ+LJ77OvEf2ODp5sKi5yjQrBs+D1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Cc: Zixian Zeng <sycamoremoon376@gmail.com>,
 Dave Klotz <DaveWK225@protonmail.com>, 
 Yixun Lan <dlan@kernel.org>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, 
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 11 Oct 2026 17:23:03 +0000
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

Hi Al,L

On Sun, 11 Oct 2026 at 20:07, Kathpalia, Tanmay
<tanmay.kathpalia@altera.com> wrote:
>
>
> On 11-10-2026 09:08, Zixian Zeng wrote:
> > On 2026/10/11 03:16, Kathpalia, Tanmay wrote:
> >>
> >> On 11-10-2026 00:32, Kathpalia, Tanmay wrote:
> >>>
> >>> On 10-10-2026 11:47, Zixian Zeng wrote:
> >>>> Hi, Dave:
> >>>>
> >>>> On 2026/10/6 02:01, Dave Klotz wrote:
> >>>>> spacemit_sdhci_get_b_max() limits every SD read in the SPL to a
> >>>>> single
> >>>>> block, so loading a ~1 MiB u-boot.itb from a card takes about 2000
> >>>>> separate commands. The controller handles multi-block PIO reads in
> >>>>> the
> >>>>> SPL: the OrangePi RV2 has loaded U-Boot from microSD with them
> >>>>> through
> >>>>> the v2026.07 and v2026.10 trees.
> >>>>>
> >>>>> Drop the limit and use the host's b_max.
> >>>>>
> >>>>> The merged v13 cover retains the v9 changelog entry choosing single=
-
> >>>>> block SD reads in SPL. This reverses that deliberate policy for the
> >>>>> recorded RV2 SPL boot use case; no general multi-card reliability
> >>>>> claim
> >>>>> is made. K1 does not advertise MMC_CAP_CMD23, so the MMC core sends
> >>>>> CMD12 after a multi-block read rather than requiring CMD23.
> >>>>> Additional
> >>>>> card models, cold boots and transfer-error recovery remain required=
.
> >>>>>
> >>>>> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> >>>>> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> >>>>> ---
> >>>>> Validation: unchanged executable change from v1; exact-base source
> >>>>> replay and checkpatch pass. The corrected combined integration, wit=
h
> >>>>> separate clock/MMC and DDR relocation fixes, passed SD SPL/FIT and
> >>>>> automatic NVMe EFI boot on the 4 GiB RV2 in a warm-boot trial.
> >>>>> This is
> >>>>> an integration result, not an isolated test of this patch.
> >>>>>
> >>>>>   drivers/mmc/spacemit_sdhci.c | 11 -----------
> >>>>>   1 file changed, 0 insertions(+), 11 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/
> >>>>> spacemit_sdhci.c
> >>>>> index 6488ae0fdb..4284553177 100644
> >>>>> --- a/drivers/mmc/spacemit_sdhci.c
> >>>>> +++ b/drivers/mmc/spacemit_sdhci.c
> >>>>> @@ -324,16 +324,6 @@
> >>>>>       return 0;
> >>>>>   }
> >>>>>   -static int spacemit_sdhci_get_b_max(struct udevice *dev, void
> >>>>> *dst,
> >>>>> -                    lbaint_t blkcnt)
> >>>>> -{
> >>>>> -    struct mmc *mmc =3D mmc_get_mmc_dev(dev);
> >>>>> -
> >>>>> -    if (IS_ENABLED(CONFIG_SPL_BUILD) && mmc && IS_SD(mmc))
> >>>>> -        return 1;
> >>>>> -    return mmc->cfg->b_max;
> >>>>> -}
> >>>>> -
> >>>>>   static void spacemit_sdhci_set_control_reg(struct sdhci_host *hos=
t)
> >>>>>   {
> >>>>>       struct mmc *mmc =3D host->mmc;
> >>>>> @@ -574,7 +564,6 @@
> >>>>>         spacemit_mmc_ops =3D sdhci_ops;
> >>>>>       spacemit_mmc_ops.wait_dat0 =3D spacemit_sdhci_wait_dat0;
> >>>>> -    spacemit_mmc_ops.get_b_max =3D spacemit_sdhci_get_b_max;
> >>>>>         ret =3D clk_get_bulk(dev, &plat->clks);
> >>>>>       if (ret) {
> >>>> Using the current version of the next branch u-boot (ed869863c7),
> >>>> with your MMC patch series applied.
> >>>> Since the SPI controller is not enabled by default on the BananaPi-F=
3,
> >>>> I also applied another patch series:
> >>>> Link: https://lore.kernel.org/u-boot/
> >>>> cover.1790976767.git.DaveWK225@protonmail.com/
> >>>>
> >>>> I tested u-boot SPL with three SD cards on a BananaPi-F3 and found
> >>>> a reproducible issue, the specific error I encountered is spl:
> >>>> partition error (Error: -38)
> >>>> At the meantime, when i was revert the commit:
> >>>> mmc: k1: let the SPL read SD cards more than one block at a time
> >>>> the error has gone. Same SD card, same operation steps.
> >>>> Maybe BananaPi-F3 do not support read SD cards more than one block
> >>>> at a time?
> >>>>
> >>>>
> >>>
> >>> Hi Zixian,
> >>>
> >>> Thanks for testing this on the BananaPi-F3 and reporting this. The
> >>> same cards and steps failing only with this patch shows that
> >>> multi-block SD reads in the SPL are not reliable yet.
> >>>
> >>> I would request to try one more experiment before dropping it.
> >>> Please add MMC_CAP_CMD23 to host->host_caps and boot the same cards
> >>> again. CMD23 (SET_BLOCK_COUNT) tells the card how many blocks to
> >>> transfer. mmc_read_blocks() then uses CMD23 plus CMD18, and it does
> >>> not send CMD12 afterwards. The current driver does not set
> >>> MMC_CAP_CMD23, so a multi-block read is CMD18 followed by CMD12.
> >>>
> >>> After the SCR is read, the MMC core clears MMC_CAP_CMD23 when the car=
d
> >>> does not advertise SD_SCR_CMD23_SUPPORT. Those cards stay on CMD18
> >>> plus CMD12.
> >>>
> >>> This also matches Eric's earlier note that on K1 ADMA depends on CMD2=
3:
> >>> https://patchwork.ozlabs.org/project/uboot/patch/20260707-m4-v4-3-
> >>> dbd01185f911@riscstar.com/
> >>>
> >>> If the CMD23 test also fails, I agree that this patch should be
> >>> dropped.
> >>>
> >>
> >> Hi Zixian,
> >>
> >> A few follow-up questions about the SPL-only failure:
> >>
> >> The callback limits reads only when CONFIG_SPL_BUILD is enabled. U-Boo=
t
> >> proper already uses mmc->cfg->b_max, even without this patch.
> >> Therefore, multi-block SD reads should already be used in U-Boot prope=
r.
> >>
> >> Could you please boot U-Boot proper from another device and test a
> >> multi-block read from the same SD cards?
> >> Could you also compare the following between SPL and U-Boot proper?
> >>
> >> - selected SD timing mode
> >> - card clock frequency
> >> - bus width
> >> - PIO, SDMA, or ADMA transfer path
> >> - whether the card advertises CMD23 support
> >>
> >> Although both stages use the same driver source, they may use differen=
t
> >> configuration options, transfer paths, clocks, and timing modes. This
> >> could explain why CMD18 works in U-Boot proper but fails in SPL.
> >>
> >> Regards,
> >> Tanmay
> >
> > Hi, Tanmay,
> >
> > Sure, I've added some print logs, which you can see below:
> >
> > commit 53c0ff5f65b0c7c4ae9f4563265741cd0ca23a0c
> > Author: Zixian Zeng <sycamoremoon376@gmail.com>
> > Date:   Sun Oct 11 09:34:03 2026 +0800
> >
> >     Add mmc debug log
> >
> >     Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> >
> > diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> > index a619440fc4c..6e18d13884a 100644
> > --- a/drivers/mmc/mmc.c
> > +++ b/drivers/mmc/mmc.c
> > @@ -458,6 +458,13 @@ static int mmc_read_blocks(struct mmc *mmc, void
> > *dst, lbaint_t start,
> >         struct mmc_cmd cmd;
> >         struct mmc_data data;
> >
> > +       if (blkcnt > 1)
> > +               printf("mmc: multi-blk blkcnt=3D%lu clk=3D%u mode=3D%u
> > width=3D%u caps=3D%x cmd23_host=3D%u scr0=3D%x cmd23_card=3D%u\n",
> > +                      (ulong)blkcnt, mmc->clock,
> > +                      (unsigned)mmc->selected_mode, mmc->bus_width,
> > +                      mmc->host_caps, !!(mmc->host_caps &
> > MMC_CAP_CMD23),
> > +                      mmc->scr[0], !!(mmc->scr[0] &
> > SD_SCR_CMD23_SUPPORT));
> > +
> >         if (blkcnt > 1 && (mmc->host_caps & MMC_CAP_CMD23)) {
> >                 cmd.cmdidx =3D MMC_CMD_SET_BLOCK_COUNT;
> >                 cmd.cmdarg =3D blkcnt & 0x0000ffff;
> > @@ -483,8 +490,12 @@ static int mmc_read_blocks(struct mmc *mmc, void
> > *dst, lbaint_t start,
> >         data.blocksize =3D mmc->read_bl_len;
> >         data.flags =3D MMC_DATA_READ;
> >
> > -       if (mmc_send_cmd(mmc, &cmd, &data))
> > +       if (mmc_send_cmd(mmc, &cmd, &data)) {
> > +               log_err("mmc: cmd%u read failed: blks=3D%lu blksz=3D%lu
> > arg=3D%lx\n",
> > +                       cmd.cmdidx, (ulong)blkcnt,
> > (ulong)mmc->read_bl_len,
> > +                       (ulong)cmd.cmdarg);
> >                 return 0;
> > +       }
> >
> >         if (blkcnt > 1 && !(mmc->host_caps & MMC_CAP_CMD23)) {
> >                 if (mmc_send_stop_transmission(mmc, false)) {
> > @@ -547,6 +558,8 @@ ulong mmc_bread(struct blk_desc *block_dev,
> > lbaint_t start, lbaint_t blkcnt,
> >         }
> >
> >         if (mmc_set_blocklen(mmc, mmc->read_bl_len)) {
> > +               log_err("mmc: CMD16 blocklen=3D%lu failed, read of %lu
> > blocks aborted\n",
> > +                       (ulong)mmc->read_bl_len, (ulong)blkcnt);
> >                 pr_debug("%s: Failed to set blocklen\n", __func__);
> >                 return 0;
> >         }
> > @@ -556,6 +569,8 @@ ulong mmc_bread(struct blk_desc *block_dev,
> > lbaint_t start, lbaint_t blkcnt,
> >         do {
> >                 cur =3D (blocks_todo > b_max) ? b_max : blocks_todo;
> >                 if (mmc_read_blocks(mmc, dst, start, cur) !=3D cur) {
> > +                       log_err("mmc: read of %lu blocks at lba %lx
> > failed (b_max=3D%u)\n",
> > +                               (ulong)cur, (ulong)start, b_max);
> >                         pr_debug("%s: Failed to read blocks\n",
> > __func__);
> >                         return 0;
> >                 }
> > diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> > index 962a99cd05a..339b222bb68 100644
> > --- a/drivers/mmc/sdhci.c
> > +++ b/drivers/mmc/sdhci.c
> > @@ -131,6 +131,7 @@ static int sdhci_transfer_data(struct sdhci_host
> > *host, struct mmc_data *data)
> >         dma_addr_t start_addr =3D host->start_addr;
> >         unsigned int stat, rdy, mask, timeout, block =3D 0;
> >         bool transfer_done =3D false;
> > +       ulong t0 =3D get_timer(0);
> >
> >         timeout =3D 1000000;
> >         rdy =3D SDHCI_INT_SPACE_AVAIL | SDHCI_INT_DATA_AVAIL;
> > @@ -138,6 +139,13 @@ static int sdhci_transfer_data(struct sdhci_host
> > *host, struct mmc_data *data)
> >         do {
> >                 stat =3D sdhci_readl(host, SDHCI_INT_STATUS);
> >                 if (stat & SDHCI_INT_ERROR) {
> > +                       log_err("sdhci: data err irq=3D%x present=3D%x
> > mode=3D%x blksz=3D%x blkcnt=3D%x blocks=3D%u/%u t=3D%lums\n",
> > +                               stat,
> > +                               sdhci_readl(host, SDHCI_PRESENT_STATE),
> > +                               sdhci_readw(host, SDHCI_TRANSFER_MODE),
> > +                               sdhci_readw(host, SDHCI_BLOCK_SIZE),
> > +                               sdhci_readw(host, SDHCI_BLOCK_COUNT),
> > +                               block, data->blocks, get_timer(t0));
> >                         log_debug("Error detected in status(%#x)!\n",
> > stat);
> >                         return -EIO;
> >                 }
> > @@ -294,6 +302,11 @@ static int sdhci_send_command(struct mmc *mmc,
> > struct mmc_cmd *cmd,
> >                                 SDHCI_BLOCK_SIZE);
> >                 sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> >                 sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
> > +               if (data->blocks > 1)
> > +                       printf("sdhci: multi cmd%u arg=3D%lx blks=3D%u
> > blksz=3D%u mode=3D%x dma=3D%u\n",
> > +                              cmd->cmdidx, (ulong)cmd->cmdarg,
> > data->blocks,
> > +                              data->blocksize, mode,
> > +                              !!(host->flags & USE_DMA));
> >         } else if (cmd->resp_type & MMC_RSP_BUSY) {
> >                 sdhci_writeb(host, 0xe, SDHCI_TIMEOUT_CONTROL);
> >         }
> > @@ -325,8 +338,12 @@ static int sdhci_send_command(struct mmc *mmc,
> > struct mmc_cmd *cmd,
> >         if ((stat & (SDHCI_INT_ERROR | mask)) =3D=3D mask) {
> >                 sdhci_cmd_done(host, cmd);
> >                 sdhci_writel(host, mask, SDHCI_INT_STATUS);
> > -       } else
> > +       } else {
> > +               log_err("sdhci: cmd%u status mismatch irq=3D%x mask=3D%=
x
> > present=3D%x\n",
> > +                       cmd->cmdidx, stat, mask,
> > +                       sdhci_readl(host, SDHCI_PRESENT_STATE));
> >                 ret =3D -1;
> > +       }
> >
> >         if (!ret && data)
> >                 ret =3D sdhci_transfer_data(host, data);
> > diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.=
c
> > index 13bf6bf6000..23c655c6def 100644
> > --- a/drivers/mmc/spacemit_sdhci.c
> > +++ b/drivers/mmc/spacemit_sdhci.c
> > @@ -640,6 +640,19 @@ static int spacemit_sdhci_probe(struct udevice *de=
v)
> >                 goto err_reset;
> >
> >         spacemit_sdhci_phy_init(dev, host);
> > +
> > +       {
> > +               u32 caps =3D sdhci_readl(host, SDHCI_CAPABILITIES);
> > +               const char *path =3D (host->flags & USE_ADMA64) ?
> > "ADMA64" :
> > +                                  (host->flags & USE_ADMA) ? "ADMA" :
> > +                                  (host->flags & USE_SDMA) ? "SDMA" :
> > "PIO";
> > +
> > +               printf("sdhci: %s path=3D%s flags=3D%x caps_sdma=3D%u
> > caps_adma2=3D%u max_clk=3D%u\n",
> > +                      dev->name, path, host->flags,
> > +                      !!(caps & SDHCI_CAN_DO_SDMA),
> > +                      !!(caps & SDHCI_CAN_DO_ADMA2),
> > +                      host->max_clk);
> > +       }
> >         return 0;
> >
> >         /*
> >
> >
> > commit 75d6b28ba7b020d3100586f586ee6d1a4488ac84
> > Author: Zixian Zeng <sycamoremoon376@gmail.com>
> > Date:   Sun Oct 11 09:33:20 2026 +0800
> >
> >     debug: Add MMC_CAPS_CMD23
> >
> >     Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> >
> > diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.=
c
> > index 88e06a681ca..13bf6bf6000 100644
> > --- a/drivers/mmc/spacemit_sdhci.c
> > +++ b/drivers/mmc/spacemit_sdhci.c
> > @@ -624,7 +624,7 @@ static int spacemit_sdhci_probe(struct udevice *dev=
)
> >         /* Set quirks */
> >         host->quirks =3D SDHCI_QUIRK_WAIT_SEND_CMD |
> >                        SDHCI_QUIRK_32BIT_DMA_ADDR;
> > -       host->host_caps =3D MMC_MODE_HS | MMC_MODE_HS_52MHz;
> > +       host->host_caps =3D MMC_MODE_HS | MMC_MODE_HS_52MHz |
> > MMC_CAP_CMD23;
> >         host->max_clk =3D plat->cfg.f_max;
> >
> >         plat->cfg.f_min =3D SDHC_MIN_CLOCK;
> >
> >
> > With appling these two commits, Debug logs as follows:
> >
> > =E2=8B=8A> hack@morise =E2=8B=8A> ~/k/u-boot on k1-dave-mmc =E2=A5=84 g=
it log --oneline
> > origin/next..HEAD
> > 53c0ff5f65b (HEAD -> k1-dave-mmc) Add mmc debug log
> > 75d6b28ba7b debug: Add MMC_CAPS_CMD23
> > 6b4af8b1dd8 mmc: k1: do not release the shared AXI clock and reset on
> > probe failure
> > 4114764d716 mmc: k1: let the SPL read SD cards more than one block at
> > a time
> > 6676ce89521 mmc: k1: handle a missing max-frequency and
> > clk_set_rate()'s return value
> > 6427189ef33 spacemit: k1: fall back to the other boot devices in SPL
> > b58a31797d7 spacemit: k1: do not require a PMIC or an SPI controller
> > in SPL
> >
> > U-Boot SPL 2026.10-rc5-00641-g53c0ff5f65b0 (Oct 11 2026 - 10:31:28 +080=
0)
> > Fail to detect board:-2
> > vdd_core, value:900000
> > vdd_1v8, value:1800000
> > vdd_1v8_mmc, value:1800000
> > DDR firmware: [0xc081d700]:0xf0227179, size:0x8d98
> > DDR is ready
> > No SPI controller (-19)
> > Trying to boot from MMC2
> > sdhci: mmc@d4280000 path=3DPIO flags=3D0 caps_sdma=3D1 caps_adma2=3D1
> > max_clk=3D204800000
> > mmc: multi-blk blkcnt=3D32 clk=3D50000000 mode=3D2 width=3D4 caps=3D300=
207ef
> > cmd23_host=3D1 scr0=3D2358043 cmd23_card=3D1
> > sdhci: multi cmd18 arg=3D2 blks=3D32 blksz=3D512 mode=3D32 dma=3D0
> > sdhci: data err irq=3D408020 present=3D1070800 mode=3D32 blksz=3D7200
> > blkcnt=3D12 blocks=3D12/32 t=3D2ms
> > mmc: cmd18 read failed: blks=3D32 blksz=3D512 arg=3D2
> > mmc: read of 32 blocks at lba 2 failed (b_max=3D65535)
> > sdhci: cmd16 status mismatch irq=3D18000 mask=3D1 present=3D1070000
> > sdhci: cmd16 status mismatch irq=3D18000 mask=3D1 present=3D1070000
> > sdhci: cmd16 status mismatch irq=3D18000 mask=3D1 present=3D1070000
> > sdhci: cmd16 status mismatch irq=3D18000 mask=3D1 present=3D1070000
> > sdhci: cmd16 status mismatch irq=3D18000 mask=3D1 present=3D1070000
> > mmc: CMD16 blocklen=3D512 failed, read of 1 blocks aborted
> > spl: partition error
> > Error: -38
> > SPL: Unsupported Boot Device!
> > Trying to boot from MMC1
> > alloc space exhausted ptr 104380 limit 100000
> > Aligned buffer alloc failed
> > spl: could not find mmc device 0. error: -19
> > Error: -19
> > SPL: Unsupported Boot Device!
> > Trying to boot from SPI
> > Invalid bus 0 (err=3D-19)
> > SPI probe failed.
> > Error: -19
> > SPL: Unsupported Boot Device!
> > SPL: Unsupported Boot Device!
> > SPL: failed to boot from all boot devices
> > ### ERROR ### Please RESET the board ###
> >
> >
> > After I revert the multi-block SD read commit,
> > I booted into u-boot proper. Debug logs as follows:
> >
> > =E2=8B=8A> hack@morise =E2=8B=8A> ~/k/u-boot on k1-dave-mmc =E2=A5=84 g=
it log --oneline
> > origin/next..HEAD
> > 55e8da25a70 (HEAD -> k1-dave-mmc) Revert "mmc: k1: let the SPL read SD
> > cards more than one block at a time"
> > 53c0ff5f65b Add mmc debug log
> > 75d6b28ba7b debug: Add MMC_CAPS_CMD23
> > 6b4af8b1dd8 mmc: k1: do not release the shared AXI clock and reset on
> > probe failure
> > 4114764d716 mmc: k1: let the SPL read SD cards more than one block at
> > a time
> > 6676ce89521 mmc: k1: handle a missing max-frequency and
> > clk_set_rate()'s return value
> > 6427189ef33 spacemit: k1: fall back to the other boot devices in SPL
> > b58a31797d7 spacemit: k1: do not require a PMIC or an SPI controller
> > in SPL
> >
> >
> > U-Boot SPL 2026.10-rc5-00642-g55e8da25a70c (Oct 11 2026 - 10:38:42 +080=
0)
> > Fail to detect board:-2
> > vdd_core, value:900000
> > vdd_1v8, value:1800000
> > vdd_1v8_mmc, value:1800000
> > DDR firmware: [0xc081d740]:0xf0227179, size:0x8d98
> > DDR is ready
> > No SPI controller (-19)
> > Trying to boot from MMC2
> > sdhci: mmc@d4280000 path=3DPIO flags=3D0 caps_sdma=3D1 caps_adma2=3D1
> > max_clk=3D204800000
> >
> > <debug_uart>
> >
> >
> > U-Boot 2026.10-rc5-00642-g55e8da25a70c (Oct 11 2026 - 10:38:42 +0800)
> >
> > DRAM:  4 GiB
> > Core:  339 devices, 23 uclasses, devicetree: separate
> > MMC:   sdhci: mmc@d4281000 path=3DPIO flags=3D0 caps_sdma=3D1 caps_adma=
2=3D1
> > max_clk=3D204800000
> > sdhci: mmc@d4280000 path=3DPIO flags=3D0 caps_sdma=3D1 caps_adma2=3D1
> > max_clk=3D204800000
> > mmc@d4280000: 1, mmc@d4281000: 0
> > Loading Environment from nowhere... OK
> > In:    serial@d4017000
> > Out:   serial@d4017000
> > Err:   serial@d4017000
> > Net:   No ethernet found.
> > =3D> mmc dev 1
> > mmc: multi-blk blkcnt=3D32 clk=3D50000000 mode=3D2 width=3D4 caps=3D300=
207ef
> > cmd23_host=3D1 scr0=3D2358043 cmd23_card=3D1
> > sdhci: multi cmd18 arg=3D2 blks=3D32 blksz=3D512 mode=3D32 dma=3D0
> > mmc: multi-blk blkcnt=3D32 clk=3D50000000 mode=3D2 width=3D4 caps=3D300=
207ef
> > cmd23_host=3D1 scr0=3D2358043 cmd23_card=3D1
> > sdhci: multi cmd18 arg=3D2 blks=3D32 blksz=3D512 mode=3D32 dma=3D0
> > ... omit duplicate logs
> > mmc: multi-blk blkcnt=3D2 clk=3D50000000 mode=3D2 width=3D4 caps=3D3002=
07ef
> > cmd23_host=3D1 scr0=3D2358043 cmd23_card=3D1
> > sdhci: multi cmd18 arg=3D82002 blks=3D2 blksz=3D512 mode=3D32 dma=3D0
> > switch to partitions #0, OK
> > mmc1 is current device
> > =3D>
> > =3D> mmc list
> > mmc@d4280000: 1 (SD)
> > mmc@d4281000: 0
> > =3D>
> > =3D> mmc info
> > Device: mmc@d4280000
> > Manufacturer ID: 3
> > OEM: 5344
> > Name: SD32G
> > Bus Speed: 50000000
> > Mode: SD High Speed (50MHz)
> > Rd Block Len: 512
> > SD version 3.0
> > High Capacity: Yes
> > Capacity: 29.7 GiB
> > Bus Width: 4-bit
> > Erase Group Size: 512 Bytes
> >
> > I enabled MMC_CAP_CMD23 and the card does support it (SCR bit 1,
> > cmd23_host=3D1 and cmd23_card=3D1 in the log above), so the SPL really
> > used SET_BLOCK_COUNT + CMD18 without CMD12 - and it still aborts the
> > data phase with SDHCI_INT_DATA_END_BIT after ~20 of 32 blocks.
> > Booting U-Boot proper and issuing the same 32 block CMD18 from the same
> > card succeeds, with the same PIO path (flags=3D0, dma=3D0), the same SD=
_HS
> > mode, the same 4-bit bus and the same CMD23 usage.
> > So I think CMD23 is not the trigger, the SPL fails with the FIFO
> > permanently backed up (it drains slower than card delivers, so the
> > controller has to stop the SD clock inside a block).
> >
> > Now answering your questions:
> > mode    : mode=3D2 =3D SD_HS, in both stages
> > clock   : requested 50 MHz (SD_HS) in both stages
> > bus     : 4-bit bus, in both stages
> > path    : PIO in both stages
> > CMD23   : the card supports it and both stages use CMD23 + CMD18
> >
> >
>
> Hi Zixian,
>
> Thanks for the logs.
>
> I hit the same pattern while testing the Cadence SD6HC driver.
> Multi-block reads failed and single-block reads worked. On that board
> the host and the card were in 1.8 V mode, but the I/O supply had been
> left at 3.3 V. A short transfer got through; a longer one failed on the
> data lines.
> Both stages on K1 use the same PIO loop, so a FIFO that drains slower
> than the card delivers would show up in U-Boot proper as well. Your
> SPL/proper split fits an electrical setup difference.
>
> The SPL failure is irq=3D408020. Bit 22 is the Data End Bit Error (EDEB,
> SD mode only): the controller detected 0 at the end-bit position of
> read data on DAT, or of the write CRC status. That is a bad edge on
> the data line during the transfer.
>
> On the Banana Pi F3, aldo1 is vqmmc-supply of &sdhci0. The U-Boot
> dtsi names it vdd_1v8_mmc, and the SPL prints "vdd_1v8_mmc,
> value:1800000" before MMC2. set_vdd_mmc() in board/spacemit/k1/spl.c,
> called from board_init_f(), writes 1800000. The dts leaves aldo1 at
> 0.5 V to 3.4 V. SD High Speed (mode=3D2) uses 3.3 V signaling; 1.8 V is
> only after a UHS switch. mmc1_cfg is power-source 3300, and
> mmc1_uhs_cfg is the 1.8 V state. For this mode the rail should be 3.3 V.
>
> CONFIG_SPL_MMC_IO_VOLTAGE is not set, so mmc_set_signal_voltage() is a
> stub and signal_voltage stays MMC_SIGNAL_VOLTAGE_000. aldo1 stays at
> 1.8 V. U-Boot proper has CONFIG_MMC_IO_VOLTAGE. mmc_set_initial_state()
> requests MMC_SIGNAL_VOLTAGE_330, so the driver writes 3300000 to the
> same vqmmc-supply and clears SDHCI_CTRL_VDD_180 before the transfer
> that succeeds.
>
> CONFIG_SPL_PINCTRL is not set either. The driver calls
> pinctrl_select_state() under IS_ENABLED(CONFIG_PINCTRL), but that
> function is a stub unless CONFIG_IS_ENABLED(PINCTRL), and the return
> is ignored. SPL never applies mmc1_cfg. Proper selects "default" for
> SD_HS, which is that state.
>
> Keeping the multi-block path, set_vdd_mmc() to 3300000, or enable
> CONFIG_SPL_MMC_IO_VOLTAGE. If the 32-block CMD18 still fails, enable
> CONFIG_SPL_PINCTRL so mmc1_cfg is applied. If either makes the read
> succeed, this is the F3 failure.
>
We need to enable CONFIG_SPL_SPACEMIT_GPIO?

Thanks. I am seeing the same issue on the F3 board.
Since spacemit/k1-musepi-pro is configured as the default device tree,
do we also need to make similar changes to k1-bananapi-f3-u-boot.dtsi?

$ grep spacemit configs/spacemit_k1_defconfig
CONFIG_DEFAULT_DEVICE_TREE=3D"spacemit/k1-musepi-pro"
CONFIG_OF_LIST=3D"spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"

On my board, the system fails with the following error: Unhandled
exception: Illegal instruction
Could this be caused by k1-bananapi-f3-u-boot.dtsi not being updated
in the same way as
spacemit/k1-musepi-pro?

sys: 0x2
try sd...
bm:3
j...

<debug_uart>

U-Boot SPL 2026.10-00722-g6eaefa1cf807-dirty (Oct 11 2026 - 18:36:52 +0530)
Fail to detect board:-2
vdd_core, value:900000
vdd_1v8, value:1800000
vdd_1v8_mmc, value:1800000
DDR firmware: [0xc081dc80]:0xf0227179, size:0x8d98
DDR is ready
jedec_spi_nor flash@0: unrecognized JEDEC id bytes: 00, 00, 00
Fail to detect spi nor flash.
Trying to boot from MMC2
sdhci: mmc@d4280000 path=3DPIO flags=3D0 caps_sdma=3D1 caps_adma2=3D1 max_c=
lk=3D204800000
Unhandled exception: Illegal instruction
EPC: 0000000000200000 RA: 00000000c08017fa TVAL: 000000006d9058eb

Code: 0001 0006 0000 0000 0000 0000 0000 0000 (58eb 6d90)


resetting ...
reset not supported yet
### ERROR ### Please RESET the board ###

> Regards,
> Tanmay
>
Thanks
-Anand
