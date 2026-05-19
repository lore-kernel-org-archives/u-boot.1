Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046DDCD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 20:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D7EA84707;
	Tue, 19 May 2026 22:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JqqANdKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A252846EC; Tue, 19 May 2026 22:00:58 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC4A8485A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 22:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so666164966b.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 13:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220855; cv=none;
 d=google.com; s=arc-20240605;
 b=GC3/0BS4PIvdsdXqzdbWWUhccM6x76O0S6r3hTK04z4HE1bXy7Ke+1cN3Cs2eApGjl
 8gMi6HI0LHyBV6z94YTBWelSnTXChzRcPVlHSs7hgS7V+7RdP/F+f+/lj6yzbiKVqRxk
 CU5SRAuCKIIRq8yB2LovNyGGHAFKkOuy2Km1+up5CMJbdfhKi1C8xB8AeGKraPAiKs2r
 EHljqCDPDCPOlMgXcpWOseVEY8ebUbsE1/Psb7IZYMyrO07H/xYXpWWjxk0+h0RLpDtH
 mzC19O7Yg2BOOODUNoef440QK8YMWu769xOlKuIFNLhX0pU38THi0V71UZJGpwoKAAn9
 tuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sWQr185us1DFSlKchLrpfMSQoSkpQKMiKjcWvQQMoeY=;
 fh=bXcJEDWYD+jIZQWj4Gg0aUzbqcB+tBGQCxY2GRHn7Bk=;
 b=eWZVLGPGILVZR/eIrLfc5qRd8vJ+nqRO5qKe6fVyrEAxahtE64lVdmlcU6knU3yI7A
 kmWF5s1WrDUEijcYokfvF2TUFJO/xZ1xqMMpeO3CMorjCuWt38DIWz+xvKNMEHGsyMyc
 XL2JQqnUzZzS7YirrKAUOtr0tC8dIrf6k5+j4bFqco85ajGRltu3hwGxk+IpwDEFVeM+
 Hs27MuN3s7m8mvStT7k10lL0J7NHwZJzfjeo4G/1mTNioCyj15yVv9EuCmdWlQwioC/3
 2aajKdCQmb7dGKGV8trMEp3VbN8pHnrpLEpE5FxTXsbuZAYJ48zR68AXKFGAJ132nrQL
 pXHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779220855; x=1779825655; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sWQr185us1DFSlKchLrpfMSQoSkpQKMiKjcWvQQMoeY=;
 b=JqqANdKXHZljGitJ1bnDpukaZ2X71mkYflKrJaPf+7L14rq1Ofsjmtsmx2jX+wjXaZ
 xHWqdunSTYrlfAkX9/lSRAk3m7ielYUR7OrSk3LbWXEZOsLGNSnSrmkLeNotdymE3RZ4
 nKKw2uP11+z6ytUkCw27XlZT7WbPFnpbPQxOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779220855; x=1779825655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWQr185us1DFSlKchLrpfMSQoSkpQKMiKjcWvQQMoeY=;
 b=U6Lfvz/mKvZveyVp14nj7ycE+N2ZzPoRyIVtpoig0mAk4kRSqrnEo+z7KIVkyphlsJ
 Vr1JfzhxxBXVG7pb+5SJmSKRRa007KjUAnQ/o1P8llEk4Wzjcuryj1KrMI38WXbM5pJy
 cvwRusKKwsd0fIJqSDZWx2SZmeLMrNB24CTQoDeEjc1DNZ08kUr2/v0PfdNqxVEaAv89
 xtZrA0DITZ2lxG4BW1SGljWbkqeFgMUr2OaRsjIMixwKgvzxVC3wuLZLItu6DfjuEa0m
 KX/VtGvDTG7+hkV7Tshp141Tsji1XaoVzUc3sw/zpI6XBkCUTXkEoBCr+l1iAhOHMmOh
 RkJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/O0K617sUKY29sCWpmyrbAC/7Bpxdz3kZxhL4ThvN87H28jaq52ZCq/apcnIavqvmwjz88Vfw=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl7Jgi7cCdfjAlwWB0p7BxA9Q6hlX1ZolupYyN6+xXXv4Nx3OX
 RN6aG5yIvdp19K4LhLElzl3JkmOgjJDQs/sJybAjMZokEnqq5PGAyNfAsEH+elZ7MQ+4k3TMZNK
 jl+xBgNar4zsu1JJ96uZw82bTzM4xgel7RcEQkb1e
X-Gm-Gg: Acq92OHmaZ/LiAKipLKrAslrNSvrrjCQtxN835QJTlLA3n5zIzty2bdUbtIX2r48knQ
 5rzZGqPKscpqBL/blTf+vQToK8Lfhgo4Pf20PnOoMMeM0ZhT57PP01PatpG/GX0AcSS0W7YWIqN
 msaH4MEmO8YVv/gwL2qPx/tpKatujTBY1sBFo6cTFcimYQhWNNU3ZNIzW7r2cM28l+RiB5rEYdU
 6wMTSferDewalS7lO37q8dhIgeaSLj3j1oLc+5yvi0z9Lsji+9yNVn5k4uhcneheEc581UmyZTG
 CKJHJQ==
X-Received: by 2002:a17:906:730b:b0:bd5:7c3:ac9e with SMTP id
 a640c23a62f3a-bd517aa8105mr1142870366b.46.1779220855252; Tue, 19 May 2026
 13:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-9-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 14:00:41 -0600
X-Gm-Features: AVHnY4KC0GDkeKmpBF700SEAxCy3NKu-3GUv9icrLt_Kv_du43jZqg81h26JHTg
Message-ID: <CAFLszThSuXELXXsdkz09FOtmL+XwE0gz-J8qeWR-MyAranzMxA@mail.gmail.com>
Subject: Re: [PATCH 8/9] test: env: allow optional date field in ls output
 assertion
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Daniel Palmer <daniel@thingy.jp>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> test: env: allow optional date field in ls output assertion
>
> fs_ls_generic() now prints a date between the file size and filename
> when the filesystem sets FS_CAP_DATE (currently FAT and ext4).
>
> Adjust the assert in test_env.py().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/py/tests/test_env.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
> @@ -523,7 +523,7 @@ def test_env_ext4(state_test_env):
>          assert 'Loading Environment from EXT4... OK' in response
>
>          response = c.run_command('ext4ls host 0:0')
> -        assert '8192   uboot.env' in response
> +        assert(re.search('8192 .*uboot.env', ''.join(response)))

run_command() returns a string, not a list. So ''.join(response)
iterates the characters and rebuilds the string; it is a no-op. Please
drop the join() and pass response directly. Also, the trailing '.' in
uboot.env is a regex metacharacter - escape it as uboot\\.env.

Regards,
Simon
