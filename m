Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79022E6748D
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 06:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A744B83C28;
	Mon, 22 Dec 2025 07:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pb++EcNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60CC883C94; Mon, 22 Dec 2025 07:38:19 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25CB183BF1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 07:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so1947451a12.0
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 22:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766385495; x=1766990295; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxPIJPeDRMis6gMjD8LIgwzEKqymh16Nsbn6hIp65Hg=;
 b=Pb++EcNcvg97el3s1Nf6659eERvcmXuZX+Bvv9ECFmnq/dNk30USq6B3ZTm38C1key
 dwwsto0zfpKbGn15Na0N19c6IVH2NhdXVQ3IULH4g4aXyi88PVWJTWLyXjF4/qUdKndn
 JQ2PzciWWdCXzBZbxHj99/bnuRXcQoECkVnI4VSx8DVlvqYfEEPhgmt0c8DUFiFRyInI
 QQBGj010UU/k5Ddqtzd7yfQR3Sybggn5W7eOMi5voiGFBST690B9ACaZu51vJVqkP7xL
 4/8eQGDMNg6XJ077yiAyKPnLxVspf+QNEJYudhMiiNWsqADzT6zx8C8Y5ifBt7aC2AOM
 tXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766385495; x=1766990295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TxPIJPeDRMis6gMjD8LIgwzEKqymh16Nsbn6hIp65Hg=;
 b=UqxChoDtEO+4cIN4ysk5rcGuqSgn1VOaOF5yXz75JYxD+0bnFqcZEN5WnHfM1ToZhD
 /pSKJYtnvG9Myw4xhdW/JJOKMv8Y2Vc7CW+oVeBJERsQ2K4TU6QZGd/EhEO6kOAx+ql/
 1DSqJ3jjXNGTF/StzoRD8aPi2C438FCyh/+dx0thSo4cjttdSePDDFcGsk7S0Z9LkuMn
 SmsPaVf2uTQ56jEHgXyRc/WwpRgenTA/nYBG5C0jaEpnFc+izY6fbaaSCAdKj9qMnAIQ
 RqTSrKXiye+c+CZm+kCEbWjH8P1oKqCDbduuYanOLtEZCSg75D1QnSJQ1Np+HDowF6fb
 c7Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhitOCiBJ2EtBSLw2iT34GIWDQjsmsA/Z37BpJMvRQk5P9VG/5h82loS0Bg/uqrsiwmfainww=@lists.denx.de
X-Gm-Message-State: AOJu0YzeCEczwVUpxbgxqSdOxiIXQ7g+l1wbEa+F19+Tdjjq6hmkf3No
 6kOOUUvxhjZFLy/lHJbp1bsdAyMKQC7olNfnipqxGSNY7T+A1I96oFzwqTTNvhWB2P8Sg2Jl/Cu
 JBZVA/pIPssFeVQXs2f05qLBc4l5fE33LhA==
X-Gm-Gg: AY/fxX7O7sUltYgK9CebYczVRfaK4u3w7SNIMQZzrRZ0jnraiNwNsOvLeBolTacqg88
 wZwhKbyVCTIvE/MtwdHNQVCewoXmWc4E6lA7uNtIvg66BdOI53mmpDtKuF93F2B6w13QqmEoL3b
 Z+WLxx0Ln8rESyT7Go8JiMQKiYF2KVF6ZGZF5JwLQngNPKUFEo9WLoTTtpH9lR1v+GFcv25PWsL
 ZtyjHP9BEA7Z8S2k6DZYD2tQXQaTIXI2jhE6qWkcLHcXNj77kBlXhE+uwlXkY+k+UwYiZ6N
X-Google-Smtp-Source: AGHT+IG5uvseMeLSUjuk3tQsVU8AHlsCF9/69sMp1aZzZjo8EhU7ZN1ApPA+K6oyjd5klqC136o8lMYB86xI/nC/94g=
X-Received: by 2002:a05:6402:3582:b0:64c:e9b6:14d6 with SMTP id
 4fb4d7f45d1cf-64ce9b616a4mr6494991a12.25.1766385495367; Sun, 21 Dec 2025
 22:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20251209025634.14466-1-mibodhi@gmail.com>
 <20251212145056.GR303283@bill-the-cat>
 <20251216170641.GY303283@bill-the-cat>
 <4e912159-3b7d-4ba0-886c-d62ad1a3654e@oss.qualcomm.com>
 <20251219162939.GS303283@bill-the-cat>
 <CAJaLiFw6if8r85LdAvus-QKhHixB9nMSLSKEnbPbESSY0zecAA@mail.gmail.com>
 <041e5a5e-8b55-4632-8e6f-f8a05852894f@oss.qualcomm.com>
In-Reply-To: <041e5a5e-8b55-4632-8e6f-f8a05852894f@oss.qualcomm.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sun, 21 Dec 2025 22:38:00 -0800
X-Gm-Features: AQt7F2p2NQ6wHhmeLZ534w9GKC_Enx_4OJJNF233NV-mIyQEcweg7KGEP2Xbk7o
Message-ID: <CAJaLiFx=ncCe0xzjy2z8-R1VyOjWqJwAKyaW0GZi2sffEcqopg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drivers: scsi: fix inaccurate block count
 reporting in scsi operations"
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
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

Hi Balaji,

On Sun, Dec 21, 2025 at 8:31=E2=80=AFPM Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
>
> On 12/20/2025 2:47 AM, Tony Dinh wrote:
> > Hi Balaji,
> >
> > On Fri, Dec 19, 2025 at 8:29=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> >> On Fri, Dec 19, 2025 at 11:04:07AM +0530, Balaji Selvanathan wrote:
> >>> Hi Tom,
> >>>
> >>> Apologies for late reply. Somehow missed the mail.
> >>>
> >>> Upon analysis, it seems the most likely root cause is Tony's 238GB di=
sk
> >>> triggers the CONFIG_SYS_64BIT_LBA code path in scsi_read function. An=
y read
> >>> beyond block 268,435,455 blocks enters this path.
> >>>
> >>> 'blks' is decremented both inside the 64-bit LBA block AND after succ=
essful
> >>> scsi_exec(), causing incorrect block count tracking and (most likely)=
 the
> >>> data abort observed.
> >>>
> >>> The fix is to remove 'blks -=3D blocks;' from inside the CONFIG_SYS_6=
4BIT_LBA
> >>> block in scsi_read() function.
> >>>
> >>> Hi Tony, can you please check with this change?
> >>>
> >>> Tom, shall I raise a new patch for this now?
> >> Thanks for looking in to this now. Yes, please post a proper patch for
> >> it so Tony can test and add a Tested-by if it works, that'll make
> >> pulling to master before release easiest.
> > FYI, I will be traveling a week from now. So it would be best if you
> > can send the patch in the next couple days. Otherwise, someone else
> > needs to do the test in time for the Jan 05 release.
>
> Hi Tony,
>
> Have posted patch for this:
> https://lore.kernel.org/u-boot/20251222042533.2024310-1-balaji.selvanatha=
n@oss.qualcomm.com/
>
> Request you to add Tested-by acknowledgement.

Could you also send this patch to my email so I can reply and add Tested-by=
?

All the best,
Tony

>
> Regards,
>
> Balaji
>
> >
> > All the best,
> > Tony
> >
> >> --
> >> Tom
