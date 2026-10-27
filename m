Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F9606A321
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=isaIF+d4;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LNODKZxv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1B96607A6;
	Tue, 27 Oct 2026 14:41:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IjVvij440Lhr; Tue, 27 Oct 2026 14:41:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 12EBD60793
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793112096;
	b=XSdH0MNirXeR5beRweMMqFB0Xdmn5bDVau4tWL13ZqBfkI/754wb4lVvn1eSj9X02Tpa
	 mGlb701pYeh/fPxJDjD1TnB0k/1v9gs5MHfIfFCi0Am+cqKEI0T2+kv0l0YLJcGVky3NV
	 3WXzaaBM2+9pbXypwdal1vP6y7wjWrTKvP54JZl73vsKz5FvXR6WvhlRUR+4jXpmQWshX
	 QZpc4LTu6AKo+X/JXOcdFmzBAJp3/i//n6oA4nidW3Z9eg0xxU7MJggSeSqILf5kBMCxG
	 DVfYZoayxOQg+wOW5zxmF+TGl7B8g9R2mTvsBGoFrLLI5PE+5F9jZkdBbDo7L1/P2Eg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793112096;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nr0nHdMT97EmUsKSygYJtHwaBoePWQSppX2CYOTg0II=;
	b=Zsy4QvCPBWfKsYLNuN0Om9hdtsTi/x67B7fcIC/ekcEHXf/BneKyEMuQSzwyjTkA+I2l
	 tiDWn+g5gu9bkgJUoRVCErRjGfwibPTlBfTTrN85Q2pBJyphsWFD7qNX5/FqVpTqnYKtT
	 f59OOmRhMLi+ktQEqfAn8Ddir9sNCg4dJ/iExlgXcY2lgbXuBD4wkP5J8nnLqDXXmI/T/
	 zUfrCKQwzaDVdAUbhQ6JZ3nMGogemPxql0Esi27+lINail0SUloSFn/JP8tYCHQ/kU0tt
	 hqtnVxEYVgYQImHC9ceesCKYEqd2QeGUPhj2XZpcwsQOOSNHmdYj7RG6onO692Nh5Nw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LNODKZxv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793112096;
	bh=nr0nHdMT97EmUsKSygYJtHwaBoePWQSppX2CYOTg0II=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=isaIF+d4g7itySJiFNkmJRxbFMAVBbKscjy3NXV9is1erD5KqYCtXXmtBwug4eGXc
	 7LeGLF1lkLSMjGSuj3jRt7CSjg+LvZnpqnAmHnigJNHnmfkbPvKMU49lP0AcO/CJ5E
	 H94nf3w31dxUx4ipxW8VW51fKRAWqw93Mallg5X8dC11h8vswPXzLlfPhj29jINViI
	 9vuKMh+1P3peurWqTozGzPXgvml6uvE5PNvFuMnEFFEs33PEDqtztvUVS0JoMFZuAP
	 xMkqJwHOUwLkT6LZBaM8YVXBe+wvTnV+n3dfaBwBHAzk2EhOJNgO4J5/r8bZg4FEp6
	 vayw9C80ZooRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12EBD60793;
	Tue, 27 Oct 2026 14:41:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90523A32
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A6E260793
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fwHIFJl-5-6D for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:41:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B4E2A60613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f36"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793112094;
 b=loWJ7ppJ+ZKxo9SH015UTFs/p9rUqa/P7/8KJF9LIZLuGUR0XibEDgawytvp7Xyqq32E
 ZzjbUoI7vkE5h+EnlVk8olKwlYPljqTQR4jEkNuXUfbNyn1M4SOyLPKZXeieLxZ8iRE7D
 oiqtUOljdo7RaN9FjPG8xorKkQ1ipp5F7MXABAhLNGp9GO+kWvxud3LwE47pTaNt9+nUv
 mecT1CFuMxMkxY38x7lhJdTkaxyPWMi8PrWAuYDpk2S14Mqk2D/vQsoclbkNTKOQWwgCI
 PCPKXDVUeFfZsPo0Xz7Epc7dkccVVNESJ8oRtke7FPqV/ceIxdezztPpxG5AM1sm/Ng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793112094;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=nr0nHdMT97EmUsKSygYJtHwaBoePWQSppX2CYOTg0II=;
 b=AJ+GRQZRexNDEpneWJnG2lAiCfBEpzbUPLjriqpV63RR5bthK2ql5r8HGKk3RFWGFtfJ
 OhODpGShwB+9PAqLmh1VL/nPu+/NIU50J2DkhV2O8OJJzunAwr+kW7uapSt/2uPC521e6
 hxhqR+IkSOP1Z0b82qPY8eWmD3chsOcct+4XlC5que6Hh+Li1ZEKXpvRkyWRB66qfOGdQ
 zPFew/pFbuV0WPg7LD6Hbn+9REDYlSxSeEaSXuvMiB6xyeYi6ePaMapl3XKzJN4BRe+cF
 zlF1l5epi+f1scXoQRf7uoBju6QsWNPPR4mnYONBc3U1Nu8Izy1pKAlTv01lZqyJqqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=LNODKZxv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::f36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=LNODKZxv
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B4E2A60613
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:41:33 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-917a707f37eso42177356d6.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793112092; cv=none;
 d=google.com; s=arc-20260327;
 b=adUb+jYuUKiWSyIaevdtBTrPO122fdn3XVdd+15LhLENZwo9NHhksromG82O818h/p
 qQN4qAX93D7qwK/rZmuiZ1bbPHgBHPM1ANeNKnoopAwXM9F9Z+qXfpMrZKp5k4t1pCFF
 FQUZGOJ8N0qvIjvVCs9bWHXtkD0CjJE9jpN65hGHu5DxHzfhAaed0MPXx7NqO24Fa9ag
 lhm19KOnXsfijTc+CbSXEePiOoecBpCaOgRNKZWfFcw7qmH4zaX4051bYIoM/gKzZeku
 8yJA1k2aab3Qe+GzCixCzt6aKa3W/KnaYBluDIRmFAHmZyMB5vTHcSJUxCFZvIW+RtT/
 9Wag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nr0nHdMT97EmUsKSygYJtHwaBoePWQSppX2CYOTg0II=;
 fh=G+KtpuihiK8Bklt6yzmn5EBM35N0DkOT5y+nPP7dcOA=;
 b=LjW9RJ4OZNOV3SYdKLQoBSjiX5oCTG0hoBkUVfV215ypmkQ7PC07byQ7KkzuxsHV67
 bB/KWiH6HxX2AQExze83RL+eCkwIycZ2/RPCFHX+JhYTbtCnc5tzfZzRYarX1iQ/Xjo0
 OtCJinInnYv9e0pqh0TO7uZZ7fPsAGZ+/ugU/29BYP1pyyEEa6lRvjSdsK9jV4+ACGmH
 DTJBeP1mjGRJZOwIfE/m63klun95KK+nWjRZpU/VuhLmA05oxk2kP0WhPCC+R7DWLh+9
 a2YDrQFtAw+cve728YXyLCvd+/+Hjo300mNT7B+hvWP8xRb6fi/lqDrv3txmETEMp05A
 pgwA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793112092; x=1793716892;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nr0nHdMT97EmUsKSygYJtHwaBoePWQSppX2CYOTg0II=;
 b=LNODKZxv+9HmVJJLryWIzamjs8ey7UjlvUKFgPcmySlmaPpD421PgqLIKjPjH18Eoa
 e6OOc33lQb9sUewAYx35mHk+0FWoi+DqJkvSIYu7u7W6fPX2SB+BYhGE+5Z9uLjayOqq
 PSC4d5tJctRVfs8+yh0zGp/ogBsWe8MzPDORRek+kbXBlWbm0xgntOnlx1dl7tm2eYeS
 Tb1rPEf4+PZGhP8wbE+12e3tZeC7TAsNAfrv2jvkOEg5bnw6rXY2hrxLqO0LwM1V6jVs
 xAemPNJ8Rc4UJBrRtLm+nnN4m4K9ZAVPimyAxmuZae6Jazb7P+kFqxot01YZ+RhY1cYy
 oJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793112092; x=1793716892;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nr0nHdMT97EmUsKSygYJtHwaBoePWQSppX2CYOTg0II=;
 b=LnIBAY6CDohqsnQWcaC7kzmS1wv8xeumaOSJ8JERREuTF7hpYVvbaRUMbH5gnsOrrg
 eWi07C/JySGDZ+baWGJL26Sgaj/w+rwbWyyWIHuZe+o9b+Mx9YbTj5XNiS7gXLdTCa4r
 WZuXJUsTDmRKOea0Z+NuIczoqm1cxrQvngf2V/PRQHSA91mzb0buEW1HwcBKeeQfxIac
 eZzBjOfJyoessM/SKr4rlFsuALhUDAwbIoCmGWXJGRUgF0WBe6cZc0JAACGZG4wp4c6C
 yOPvXu3ecoO7l8SFA4tWyvEBO9xOtf0gbkVAxfVZNv/DIgbXpEg6n6JaxqDuW+N06Poi
 rm3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwknYuI+OLvtEMQSK0PWwgdqj+3WsVws+Ru45F0K0z/rWanpUZWpVDqeYInFYy6BuE3Q9rSJDw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI/lu+URUx3uGha4J9vVnSPO+YEIpBD0eGkuDlj7XPkpGoQCuDJ
 FtKn0ErIFIPFxZoxIsxskI7lWuKGC2/mxPoIw80wWdbbeasGEHQ3wM96lK1K5pfcG/9vHHRriQ7
 N1QMBaCHU8njJq2cHsY/LC1sBiPu0SIc=
X-Gm-Gg: AYBFou0J0VFRndyCgaRnDy+aEMPRsEkP61x60cMMKXk2hxHxnPzyR7TtSo/2P1q8Ejs
 OK2LnkV6T0+CZqo5lTTNyQZPTBgFInVlZPVaHVARpKYMS6UoKcZQlqPPKTGsWYkTDRWtJZtVzCn
 WBckaK5pMGiSqKNWWR0wXLMVAt+e17kkCwVQk5JDkYsKy4oVBgjedn80Lc3Ci/lfFKImiIR3Yff
 kcNptojmvjXzXAOhpdIKCimUJJwnxmrIWpR3+/hA6x3HFq0w6GkwPXLKoQwLuDsQd7+fEmoWPYP
 N0Hq+wLQNrq4lQavda1ahHvyCbA9cIwYhye3geWa7kW+kVg86/E6uIKy84qJdFC6KUsd332WnwK
 ZkFwf0XZMEXLUxodYdzNchOmSVQeLcRHXJoz+Lp5YYpXOtN8+lLzlSxYZX7DliVYrMRUofQ9/zr
 xVOHxx5vauepGL
X-Received: by 2002:a05:6214:8085:b0:91c:61cc:179d with SMTP id
 6a1803df08f44-91c61cc17e8mr87840476d6.14.1793112091926; Tue, 27 Oct 2026
 07:41:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027123905.839-1-ansuelsmth@gmail.com>
 <20261027123905.839-5-ansuelsmth@gmail.com>
 <CAFLszThUxv-P5fx-7i6UtAKh2YXe-JExm4a19yynisDHjm9D6Q@mail.gmail.com>
In-Reply-To: <CAFLszThUxv-P5fx-7i6UtAKh2YXe-JExm4a19yynisDHjm9D6Q@mail.gmail.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Tue, 27 Oct 2026 15:41:19 +0100
X-Gm-Features: AclHuK8DIoMxmHCMO9gEKna_U_uh3oEin5slPGWmFPgQuGRoOVyiPRQLrEdx60k
Message-ID: <CA+_ehUx7jUhrmPkVPi8byLGJEHynO=pF_JhBjA+NqtOf1z4OWw@mail.gmail.com>
Subject: Re: [PATCH v11 4/8] misc: fs_loader: validate requested offset on
 reading file
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@flipper.net>, Rasmus Villemoes <ravi@prevas.dk>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neha Malcom Francis <n-francis@ti.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Il giorno mar 27 ott 2026 alle ore 15:36 Simon Glass
<sjg@chromium.org> ha scritto:
>
> Hi Christian,
>
> On 2026-10-27T12:38:55, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > misc: fs_loader: validate requested offset on reading file
> >
> > Make sure we are not requesting an offset for the requesting file beyond
> > the size of the file.
> >
> > If it's such the case, log an error and return -EINVAL.
> >
> > Code is reworked and split in various subfunction to permit re-preparing
> > the filesystem after a fs_close (called by fs_size) and reduce patch delta
> > of upcoming support for reading ONLY the size of the requested firmware.
> >
> > Dedicated mount function are created to mount relevant filesystem only once
> > and follow the same if-else logic pattern used by the prepare functions.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >
> >  drivers/misc/fw_loader/fs_loader.c | 97 ++++++++++++++++++++++++++++++--------
> >  1 file changed, 77 insertions(+), 20 deletions(-)
>
> > diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> > @@ -113,6 +123,55 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
> > +     if (upriv->offset > size) {
> > +             log_err("Invalid offset. Entry too small\n");
>
> Ideally you would include the offset and the file size, and say 'file'
> rather than 'entry', e.g.:
>
>     log_err("Offset %#x beyond file size %#llx\n", upriv->offset, size);
>
> In any case:
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>

Yes sorry I forgot to update it.
