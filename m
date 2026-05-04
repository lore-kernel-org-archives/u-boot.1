Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E0DFF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8414983EF9;
	Mon,  4 May 2026 14:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HqPiZCQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DDFB84659; Mon,  4 May 2026 14:16:06 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112218394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c80167f5716so525176a12.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896961; cv=none;
 d=google.com; s=arc-20240605;
 b=fV1Hd0e3m8dKukPVb08O3VQuboVxbpG5LKh4zsfMSudOOVIoNi/FcM/uP9xe2lgUUO
 UasC3cZea8zuu0SE82s9IfCvHJI3BPV3p8y6tjMQ9CeuNUlw1Efcz7B0gl/dChvlTAhm
 PE7TxIKQ5faIrPGnVPkp+E4Z0TfAcBA1dPzw65FuROjRA/tW8wnMbBxDWlK4QH77lTNf
 B/HjjqL9kjIOf3uJvFlIE4HnJEENxFIjGLKo6za0MfsvA8ayZuE7BOPpN0mp41xmF55u
 u7VU7UOebeUsxSBYgwCRGTF8d20EHMahzzC4gl0IrAbcUE406F2vD4m2IVBxIJ590IX0
 1Wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uWLhpxBDecpnz4ev/BsXZHafPVfH+6bg1TQRx9dDkJU=;
 fh=ZM47NY5NjwIVB0Rk5pbqSagMaOgAeQ/crhGguFcj3eE=;
 b=YroNnT7H6XHSzl4OcBJKuwn5Spadr23WF0LQ0DuiBGtRnyxM3J+aLpOCb0A9cf2oCq
 95u4wj0NPmNcmy1H0evlvi5P2oHrU4FxQZZJok5SOHaPjf9iu7HzJh9SFdVC1TffxczH
 c/uZdfAzJGc9JhhZo0vSEBWj42zRLAfXTfnlDZBIab8ha6zIqRNsOJeyBNZ94tBDr1Gf
 pHzQLv0GRUCQvDqA2FJGLPMUm7Y3UqSlfBdJYKD50AVgjfGwaqV+NdAy97qOnFvJLJF8
 RPiwfsjmNB0lXU13Whcow6ggQDJ7rygkH1/0A17TzGfV1hYXHdJcbHL9m6fdzQWDakWj
 NuRw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896961; x=1778501761; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uWLhpxBDecpnz4ev/BsXZHafPVfH+6bg1TQRx9dDkJU=;
 b=HqPiZCQi7BoCLF34v3ZtnOLolFyO5PvgKbokFGU3aHlqwNp64DtCwrdbbYmx0ueYXc
 AM4Mj0tneJm9evdYIoa+cufhNVHVhkRKc7i3UMdqW854oV3yI0rV6FX9n9P/I3w053FX
 zl5Ejk37sKCZ9nlbIsaOfRr86Rl6mpNbfHyoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896961; x=1778501761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWLhpxBDecpnz4ev/BsXZHafPVfH+6bg1TQRx9dDkJU=;
 b=sQMrFd1wwWkB+2672XMDbrqU/s9NPv6Px8JGIWbFVkrYxV8x82/Cop1N8P2WzUqQiQ
 Tmpnq3N2BZTVb0nAGPQsr8xu5V8RIvBSf5Prqn+8ylH1y8tFZUnSqA6kcKJhYeTH5r9g
 N7uAwxI4sczfa2L0cUoy/9JKbr9KFok4g6qAo8j1pWMz1Mq+X7kM4FN1YkOf3sMxANj5
 dtQGWneaM62g2qAls/QIDs0qWNTbMBBTi6leO8lLbUU+dQ9ISW7AKqsLqJflxb1V5U6F
 3sezxXslgBl4iOx7y/3fszhxhgrioAFBlGEH9lD5ZBPyG+lJS0zRQ3sxbBj6OX5BsmxK
 BVhQ==
X-Gm-Message-State: AOJu0YxAxa9wAEShMTRj0LzLTkW37Li2iwiMo2l78vmL5WuoIOZ+HID2
 tYtckFPGhsR5nW3w+GrOl6/ZFEf3e8SVcLbij6r9+UOmgigQ9obgsZLtr/tHdGBL5f3Kbsm6q+F
 u7wOs5yfpezLD5dMjKPApezRuXolkwCt2TW1L+8L7
X-Gm-Gg: AeBDieuBDeVO1L7iqjlFJ5X5w3Z4ZRlxA3Ibpy3vRa8haSSuYxI6jqu1+A77d95muLR
 Yd7K+nl/0boT7ORcW0NHX/3Zz02Uf7DoRCpD6lAOqKIJ9rz8+P33OJsi2F1fpeifbCXO5UzWyBb
 AUxBy8BpW+ZhivA9tFZrc+VdS0b89RWo11sudvid1U5hMv49/oS3I7luFfMzQUSpTo3UuagR4Qe
 n2NOskcnr8C0o3Vjgz5nCGbkf6ZeIB6cY5GsfiV1UW7rbyCZVpfCjPE7L1rwsICB7BER/bYdZTs
 cfikFau65FCPTznz
X-Received: by 2002:a05:6a20:914a:b0:3a2:d79c:4161 with SMTP id
 adf61e73a8af0-3a7f1ca373dmr9900136637.47.1777896961487; Mon, 04 May 2026
 05:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260503204936.3151124-1-sjg@chromium.org>
 <20260503204936.3151124-2-sjg@chromium.org>
 <20260504045410.GA5052@francesco-nb>
In-Reply-To: <20260504045410.GA5052@francesco-nb>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:15:33 -0600
X-Gm-Features: AVHnY4I-pp3tC6YN83QPSypDQACdRNf-oqeCMa8yiGQSdFLWwST46jsJFa5HdZ8
Message-ID: <CAFLszTj7DdLM1tn4KmE_2iWVt7epF7ADS3cSmzg=ibkQtkTzhw@mail.gmail.com>
Subject: Re: [PATCH 1/6] toradex: Quote fdtfile in preboot test
To: Francesco Dolcini <francesco@dolcini.it>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Andrew Davis <afd@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Hiago De Franco <hiago.franco@toradex.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Peng Fan <peng.fan@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Udit Kumar <u-kumar1@ti.com>
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

Hi Francesco,

On Sun, 3 May 2026 at 22:54, Francesco Dolcini <francesco@dolcini.it> wrote:
>
> Hello Simon,
>
> On Sun, May 03, 2026 at 02:49:19PM -0600, Simon Glass wrote:
> > The 15 Toradex defconfigs (apalis-imx8, apalis_imx6, the colibri
> > imx6/imx6ull/imx7/imx8x/vf families, the toradex-smarc-imx8mp/imx95
> > boards and the verdin am62/am62p/imx8mm/imx8mp boards) all carry the
> > same preboot expression:
> >
> >     test -n ${fdtfile} || setenv fdtfile ...
>
> Thanks for the patch.
>
> This was already sent weeks ago, see https://lore.kernel.org/all/20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com/
>

Thanks, I'll reply on that.

Regards,
Simon
