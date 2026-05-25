Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7182CCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A1C846E1;
	Mon, 25 May 2026 17:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jDLe0ul+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF6F846D3; Mon, 25 May 2026 17:28:22 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25E88484C
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd01481e592so1335668366b.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722900; cv=none;
 d=google.com; s=arc-20240605;
 b=JsNIf3wIznpi919X76TWxEjETP+Kw82KqC6VN2AGsRKiCVs34uRMznX5Jam0Fnxlg1
 9sw09X4kMYiKZxUkN9F6w2QxQHQhrXw6Tyd/yQwsiehIV4ALUDuBDKDCJivik80SuoUL
 O2S8nh0FGqsq0Acf98s1qbQ5pGN0N0VzIF4DS+XD7Qlg32CQuhLwgQeZKM/Q15xg9lcM
 chCvvvCSl1Lkk9hixYV3ZNqlTTSKjENsMUNf58srQ+PbtbyQrByOfWAxU/J1RTpCr7JN
 hHsZC/YGye3OI5IRKxc7m76JZnBCiYbEwO3XkuktbGsa5ueLvn7xhASAUi3ifbHTRM7/
 z01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gUTX1KF2TwWRap79TX8ah0rSvOQLAEfoqAB4qAmSWC0=;
 fh=uHnctjfjo81NP+4b9H5aVwcI8F1nm2RvYATNLKEK624=;
 b=AOff0c2UepTYLFC4jm9yt29xtWZMgcxggvjz+NIGAzl5JCmXsxnhT3JfDmjU+4rOuD
 OhhYbBfUY/sqSYG+E7mFYG9iN0NJb+ci2trOVpz67sApk+7hePiRJVa1+DZGiElQN+N2
 zuEIOImg5lb9tYer+cfeBaZ11fEVoVwe6k29MMdOXjgQVfVf4ICe2kjiLHezBhJ8/Z/m
 poJATHYqcp4KZCUQv0V6nDxSMkc4qNngbXHXLvojx2aCirzBce1YAj8ywRxZhn4Gmwht
 7c4bu0LDyR2mSOdR/5ZXsx2FCPUHVCpj0x/Z6vrtxHTeOHEiFS/Qkb0isfFlj/h70f4o
 WANA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722900; x=1780327700; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gUTX1KF2TwWRap79TX8ah0rSvOQLAEfoqAB4qAmSWC0=;
 b=jDLe0ul+byyDwBYR2PjGB0cb9gVPZvU6AnWd38sSPRaMyrVfISu3ZGJnvq110L2oj9
 U88iL1QsFzd0q4W7H7ke+ciRFI+6Q3Zc159wNhKzVOLNKbfUIhOUoLX8SKlqhskmI1O+
 UsxHdNR9d9exx82v1WAYysKrLxx10yKWxbh5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722900; x=1780327700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUTX1KF2TwWRap79TX8ah0rSvOQLAEfoqAB4qAmSWC0=;
 b=Gf0vhdP+jWeb2Nnn20rA+M2Odq82UEDiYl4luq76g4AdqYKnZEIIrn86fm5gJAkT02
 qHMhiK7Jyx3G6AoDS27p7HsI5PV+LyNDLBYsL37yW7DJ2hEtLayPonG1maWXGxurZlbt
 /L0p2cZbVx/clm4awdWyXxedLSerH3zshaWI29zwnnuQ5qBOF1PysWScDD/rpCtxC3Ih
 1ocpC1GYoXGSkD6lCFXg+gFukW97NrJ9aJ/TdKcAwd+p7cvcVzYcsosNnomCJnFbQvKx
 4R6EGX9iZLL3wL28J7DpT6W9lWEgRDhtB9is1aW2tPKOu2J/ENp0JCAjbOK+Tyt1bYUF
 AWlA==
X-Gm-Message-State: AOJu0YxVMQrbjC/Fo2qjVcW7DNVG8++R+ipMI5j/0UQtanCYZz+UqdFm
 bx58H7/y0CCrVe2BgraRO7BFoIt/QKDS2WqO+L0vl5ix7DMeR3cVzu55iVoeOGcXNyM4+vx6KZT
 zpeeoGqYKu2Tc56ePK4g/cm6fGvvj7O93e0xF2KAxkL5+XK0BMXI=
X-Gm-Gg: Acq92OEPW5FeiQn7elgZcJPOxeHUGMh0I8gZvvmT2EvZ3D/RWPkm1ttO1Vda5p/wTrU
 1Qa5syyRTPlI/iOgA1uoBRyIIBXfew/E1X09SjSUGMqk0wLQgTDQU0AvE+tDoNeUc7WOdxwYtG2
 DfV29J6zcdGZvEjX7qlwhuTu3fGfY6qHGkh6MVrMgjasIn9wqzDNeXRXpOb/54w+o6BdBWqN3WN
 zcSrKgjrVKkHaLmZfWzHniT+kTtxq5rWISkTFQiSGC5iPcK+iOMbTWhGvo2ek+lRHQ+DKVFg2Ab
 LdaYtgRWBvl1mNlY
X-Received: by 2002:a17:906:8a4a:b0:bcb:4046:63ee with SMTP id
 a640c23a62f3a-bdd25ced643mr623843966b.31.1779722900280; Mon, 25 May 2026
 08:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260519225458.5587-1-ravi@prevas.dk>
 <20260519225458.5587-4-ravi@prevas.dk>
In-Reply-To: <20260519225458.5587-4-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:28:07 -0600
X-Gm-Features: AVHnY4KF_i6oWbpA5IflIY-IEGInOaw4z9psVtfyBJlxbAV4R9D_Z6Ws34Gz5LQ
Message-ID: <CAFLszTgin=mUdzdxypMXrA867JFeesYE=fbO+-B+=Ce=X+iMLw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] test: hook up test of allowing control DTB to act
 as FIT image
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Rasmus,

On 2026-05-19T22:54:57, Rasmus Villemoes <ravi@prevas.dk> wrote:
> test: hook up test of allowing control DTB to act as FIT image
>
> Add a test demonstrating how one can embed various scripts in the
> control DTB.
>
> Verify that the source command can be used with ${fdtcontroladdr} by
> itself (invoking the default script), and with :<node-name>
> suffix. Also check that the scripts themselves can invoke 'sibling'
> scripts.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> arch/sandbox/dts/sandbox-boot.sh      |  2 ++
>  arch/sandbox/dts/sandbox-inner.sh     |  4 ++++
>  arch/sandbox/dts/sandbox-outer.sh     |  4 ++++
>  arch/sandbox/dts/sandbox_scripts.dtsi | 24 ++++++++++++++++++++++++
>  configs/sandbox_defconfig             |  2 ++
>  test/py/tests/test_source.py          | 18 ++++++++++++++++++
>  6 files changed, 54 insertions(+)

> diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
> @@ -9,6 +9,7 @@ import utils
>  @pytest.mark.buildconfigspec('cmd_echo')
>  @pytest.mark.buildconfigspec('cmd_source')
>  @pytest.mark.buildconfigspec('fit')
> +@pytest.mark.buildconfigspec('control_dtb_as_fit')
>  def test_source(ubman):

buildconfigspec markers are ANDed in conftest.py, so the entire
pre-existing test_source is now skipped on any sandbox build that has
FIT but not CONTROL_DTB_AS_FIT - so silently losing coverage of the
original source tests.

Please split the new assertions into a second function, say
test_source_control_dtb, with the extra marker on its own. That also
makes the new functionality independently selectable.

Regards,
Simon
