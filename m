Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ACBCD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C99D784A79;
	Thu,  7 May 2026 17:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hGzvrAKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D573C84B52; Thu,  7 May 2026 17:32:36 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D9784A44
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so170199766b.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167954; cv=none;
 d=google.com; s=arc-20240605;
 b=fEcEfQNyOQ+wWTPTuBCZ5Ellbc6sWDqwQpa4f4r8rTtL25OS7hePdWXatQOHlqzm1I
 GrFbvU6DnbNDlPO4GvwNY5Ckc2CSlFo/JUEAfHwuBzoi6POasmaVu7I+bNn+T2T9wBlu
 /xn8+cwEU8YMA/SEf/R8GuFlZommt7+PIkdj523Y573/d4NRIPQQ65CQ7APRl3CDudaL
 mS9vpTcNIdKOfMOKHTl8SyUR6D8QDHHnu2WWfLk/FtjPvmkNlJOIvi4pF5X0SkmYDtmR
 zKiCaX2FSRnCn5e+CKKjKpDF/gcaNIRXPA/wRKqW7RVNWlsLjeei4qycor+cXcVG4jL+
 g+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9RNrDlx7pc6a68AcEDo/AAYyA9U83tpxJuEvTb0XWDI=;
 fh=GpG0ILApjOziwMpWxVdtEc+pDfvf/OdWX72BncHhg/s=;
 b=GPtZi+F1l2oJnlu0Jfw3TO6UJPJofok5K5qywrR+DMFYLYgCJUmvwTAvJ0Dqyrchju
 E55s4f66DvPV/KBpnlcS+2TkBx1Qxq5MW4+cCRiJ597C9rw6R1rDBGV0mkeirQcqGA91
 +VnQAtF0gzgxMIMUBdONKMKg8AyF3wjdJ1lKqnz5rXHANXZUn7QypjoMHDTKdGSL8FS1
 VhNRFAX+Clztrs5cL9te4laOgqRaM8yK3pAXTujgOzaVACk33JICgatMtgUDZ5QxLKd9
 fWPEzxSpLKcFxxdjrM+py6v/0D9BSf4SP53SifnwgDBqty5XljhtO5yGm6JhnveVfyKT
 ftPg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778167954; x=1778772754; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9RNrDlx7pc6a68AcEDo/AAYyA9U83tpxJuEvTb0XWDI=;
 b=hGzvrAKdy6L6KWsxbUVHm3hsyWNkO/kPnE/55dm1bm7bRCDlOOOECiIDIcPFqpEpX2
 ISJMVXjWJ1rM/3u+O3A6m/6byJ22A7Hs96mx35UwYD9JW8LOyk43U3H0iVUN/mI+ko+R
 AH843EOUxCZuuudQzRoNADSTzUpcHnaWtboSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167954; x=1778772754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RNrDlx7pc6a68AcEDo/AAYyA9U83tpxJuEvTb0XWDI=;
 b=KLbMrK48HFlJdVe4kcAEevNDcz7SxOfzyAvAhBKiyBMGa0f0FmrtYNeEFkqV5Tecax
 hUsmnWqG2BNY4FZY0R2Q6aphVAzmHdswR8T5mw4DLkcu0hTVhkEwvFOH/Tr51Lo9kwSG
 yVLSjbbcOGvSQGTqjoS02AYBatcdH1jnymFDF4P7/Om3CPWzD3bSrW+iC3iddP1MvW7i
 GR3BgUNxkvfCBTH9xHH/FVx30V4suWq5/Tf68ERT8DriNZWJJ/lQO0Hr8UmIB2IsjyOr
 G5zIKUwlbyxtY3p54GtcN0AeEHDmMj9SCOeFDjKki8C602qPEQISzS1hVEtEO399Jfpg
 7mYQ==
X-Gm-Message-State: AOJu0YxAh4fd0FMnzQu44yHgJ9ffMeD19wQ0wAu+iNGbwLvb+dv4LH/Q
 XjfuilLyWTnvF9Ufgb+UgJ9iNOAqaedXm5fcVJCyGhrF2dvjDS9g4evw477DxszcQsOYkrkVip7
 TPpkSjr463buwsK0Cl2Db8G5LCHgl5YXGlgJJrvMv
X-Gm-Gg: AeBDiesqqSno0s+4eKCm6bSvN+QwG91jaQz9Dj0gH2U6E8pGbW7sTGpdG7S4WxoW2a/
 Iz4xxHjhFhN8bEmE30LHLFcmMByfkNILa+aMlT49GLKB3t+MghgmRwuWRluobIUwBXOusKznfmT
 DUEwiJG5iEeUqDIQx06XJjO9XvUsP4FtrbrB3QQRzL70JF2YdhW9XkajMZkqwU01sBbrz2TDzm0
 EOtbXBbzOq7ouNLAAdlpxAFbmJeaHjY0RhfkqWMIOfDWtNuZiB42BNbPOup/LmC7Kh8+yJplqzV
 88J7lRcoT7JCaJNI
X-Received: by 2002:a17:906:9f8a:b0:ba0:fd75:9c58 with SMTP id
 a640c23a62f3a-bc56d717ed5mr511723866b.32.1778167953616; Thu, 07 May 2026
 08:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260429141850.1.6f48ecca7f833b4f4b90ba78432475de1461e838@changeid>
 <CAFLszThHeODorsKtPCqFYmfSPuCJNGMTvdtUQ10yiHRhJnuCPA@mail.gmail.com>
 <449bbab5-3451-4034-a643-771d9ddb0567@siemens.com>
 <CAFLszTif8nRi8MGVmgj0hwbkCm+P3YV1trfvuVU7XxwiDAOeLw@mail.gmail.com>
 <dd5dc055-dd57-4d1e-b155-5c254f2d20a5@siemens.com>
In-Reply-To: <dd5dc055-dd57-4d1e-b155-5c254f2d20a5@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 09:32:19 -0600
X-Gm-Features: AVHnY4LoRgU3leyGmBuDfljHw7Qknl-9PLhB9ygKlmifQJJJI_vi9iQECke5bu4
Message-ID: <CAFLszTgP+g=6GafZtJn4GVvXLrvkf17ixH6BidJvLT-uZ50ULw@mail.gmail.com>
Subject: Re: [PATCH] patman: fix use in worktree
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Ludwig,

On Wed, 6 May 2026 at 05:47, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 5/5/26 16:01, Simon Glass wrote:
> > Hi Ludwig,
> >
> > On Tue, 5 May 2026 at 02:25, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >>
> >> On 5/4/26 14:31, Simon Glass wrote:
> >>> On 2026-04-29T12:18:51, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >>>> patman: fix use in worktree
> >>>>
> >>>> When using a worktree '.git' actually is a file and pygit2
> >>>> init_repository() does not like that. The intention is not to create
> >>>> a new git repo anyway so use normal constructor instead of
> >>>> init_repository().
> >>>>
> >>>> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> >>>>
> >>>> tools/patman/cser_helper.py | 4 ++--
> >>>>    tools/patman/cseries.py     | 6 +++---
> >>>>    2 files changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>>> diff --git a/tools/patman/cser_helper.py b/tools/patman/cser_helper.py
> >>>> @@ -309,7 +309,7 @@ class CseriesHelper:
> >>>>            self._copy_db_fields_to(series, ser)
> >>>>            msg = None
> >>>>            if end:
> >>>> -            repo = pygit2.init_repository(self.gitdir)
> >>>> +            repo = pygit2.Repository(self.gitdir)
> >>>
> >>> Thanks for tracking this down.
> >>>
> >>> There are more init_repository(self.gitdir) call sites have landed in
> >>> cser_helper.py and cseries.py - please can you convert those too,
> >>> otherwise the worktree case will still be broken on those paths.
> >>
> >> In which branch? In master I can only see init_repository() references
> >> in tests.
> >
> > This is in the master branch at http:...
> >
> > $ git grep init_repos
> > tools/patman/cser_helper.py:            repo =
> > pygit2.init_repository(self.gitdir)
> > tools/patman/cser_helper.py:        repo = pygit2.init_repository(self.gitdir)
> > tools/patman/cseries.py:        repo = pygit2.init_repository(self.gitdir)
> > tools/patman/cseries.py:        repo = pygit2.init_repository(self.gitdir)
> > tools/patman/cseries.py:        repo = pygit2.init_repository(self.gitdir)
>
> The patch covers exactly those :-)

Ah yes... :-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
