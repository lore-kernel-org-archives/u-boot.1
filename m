Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CF2FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 02:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D16CB846CE;
	Tue,  5 May 2026 04:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="MFh0VINa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A91084706; Tue,  5 May 2026 04:11:42 +0200 (CEST)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 103F5846C3
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 04:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-12c8cc7a77eso3930011c88.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 19:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777947097; cv=none;
 d=google.com; s=arc-20240605;
 b=JnJDrz4lTnA6gtBzJiU6fnDOXwKG4tcTdFHMz2q3xbFWgxkSQtGLMM1e9Zs6b9zqCs
 C8JGdQStzBHG/50eIovwK0mgsLBPRCxtpAq9etMQOQCo3Ja9bOxr4V0EslKl6i2aFkcf
 OjdTrd6+XH42KDtnqQSOf3uuCzJG8hTH3yq6GTFyGj5H+fM3jB9DrmpFKXQKmC+cobrY
 H/JRJJs8zgUdfqyhBS0xiiqdy8C223YiuhaxQ3BVMV9e2hSM0S1GrvcJzdXn3AvoCmMv
 vaAYgoyDiMumqrhYya4ekMzn7GZmws8fejf7ZpQQnGo1tpzSKMjeGfG2hYlq7JEOMcJ/
 W1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SfONR5o63m7RGQ3QgY5/TbPsrAvvk07nyiSxoipCNXk=;
 fh=BwXst+TRhil+Z/YkvLSkANFR7ZROpHI3zoM43Duz+lQ=;
 b=F2uKqk6oUrDuLFIJAq9VNGSG31D+jp1h0IkAuN/7CpBWgeECcJwggbTdECLTWos6C9
 In00EzmEXfeJPtH2lV3PNWf9eYIwL8gvf+7X2NHQCnkiXL88PuI1hKCsXExyPVJ59LE6
 KHSqZydq6g+nVUj3PIGi2j9fNh1M1O8y7ek7yYECfbjO8XdX8qbYTNGyA985ldZu4+JS
 bydw2R4D/C8SbXfhIccwWn6GoAB0mfrpUHwHnDpg4mS1VEgWKXehD5/c30vKsbolM+To
 MUdyCJlyN1gPVqTGlpzVUFX34X/vJYg5wr2L/TSPhG9TO+XGzJnvMgmrcurNwrhpIRJS
 wFQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777947097; x=1778551897; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SfONR5o63m7RGQ3QgY5/TbPsrAvvk07nyiSxoipCNXk=;
 b=MFh0VINab0wubmLoUHfkiVHYwtBUpjh1KU8eCBr8SR1dI5Ej2xfarGRplWrsEdT+zQ
 zPaoGuVJ08ele5ejk4134QyqU1YJjfRcEXbFmMS57qwDME0CRNzj5Jy5TE6aXDY7EghS
 bwuOj2yh+SPBHGD/znuNfvE9fB/27x/1t4X1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777947097; x=1778551897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfONR5o63m7RGQ3QgY5/TbPsrAvvk07nyiSxoipCNXk=;
 b=onoPqBjkHZKMsiUTJEE96B86nFB6mrkXIFhPMeA6/YSLU7t6p+e+Sz5Dt228pGSUM8
 WCV8vpV225bNzOjeDrNU7COqEHI1OFq5MrOqRmrXSKknxGdz5SeELuxJhZ5KRHqlw9Jn
 8wsYzxswMuYnG2dldMSURXr4bXDZBCQNfWCzSZcQGY93FToPjtG4HQRzo2gKmxEEP/5o
 UI7BDjBydmstp8OfsQJxG36/gULJrCT8tBnu2kB7OFDn33L9EEblpayJd0nUScWb8fLk
 a1oWHif8vz1nJPunQVF9r3L9pkZ0jc+1Dgup9o9zdpZGKOsnoEjeiYsjwcaVQx3DWZ/x
 VaQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UKPN9VW4vppGPTUeBfd/10rrrCn/u1m44Pfphg2B1icI3D3diuEceyrlkfNewUdYyxq2bMvk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1v9ugAzzO3s2jwGbAw3ARcl+Ec8z834Y6NP11j7p+ZlDGFG78
 q875FSB8ORk5/b09UCYVLxG3VaW5mqRxvgzQU7D+Sg2t8d2ySzU1IC8/qwRMnu4UouNkj8qyCov
 DXwIKCyPYg4HcsyHmZo8/aU4ZVyvbfHOybowqFRJdyw==
X-Gm-Gg: AeBDiet3Ub3mv/5wVPJG35DYpPPxdZVq1cshEuhzbzSyvZPezQoMjyXxncFLoZJEXQ7
 wKS7FtuHgCH6rC1vjyGP0hq0Xb5kfdmYm2MbMZRmNkXg2lmd1i9ZzXwZGLOSxqQGoKZiL+YR1bS
 +7vPfihUqd92LPIFAwj6UiYIZVKHXAksZKLn6wAvIhP4DkA1gEg9hMEPR/8s6DHoAQoAuAono3T
 /G5tQH2xpnoaO/sZMaJWdgRlPX8EIHrQIdZ9ecZ9Bpqhr+tN/H04bYds6oBJqFxiezjeBl8lAwG
 1V/Z28LuRkS9tRMt5QfhZaboZZfrvSM=
X-Received: by 2002:a05:7022:222:b0:128:d396:f2ea with SMTP id
 a92af1059eb24-130a9aeb59amr893402c88.11.1777947097146; Mon, 04 May 2026
 19:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260416093927.602613-1-daniel@thingy.jp>
 <20260504220957.GM1614990@bill-the-cat>
In-Reply-To: <20260504220957.GM1614990@bill-the-cat>
From: Daniel Palmer <daniel@thingy.jp>
Date: Tue, 5 May 2026 11:11:24 +0900
X-Gm-Features: AVHnY4InHzYcQEVwwfW8iyWHrR51rfKxGJzHRUXJ8ZMR6m-g6kfIw32oyaBHp80
Message-ID: <CAFr9PXkDJOP4KF5+=Bmyo-LaPRe0uwU05pgTALOUWPSLCPzULQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Add virtio-mmio support to m68k virt machine
To: Tom Rini <trini@konsulko.com>
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 sjg@chromium.org, u-boot@lists.denx.de
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

Hi Tom,

On Tue, 5 May 2026 at 07:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Apr 16, 2026 at 06:39:19PM +0900, Daniel Palmer wrote:
>
> > Lets start making the m68k virt machine support useful.
> >
> > First we need to fix some m68k endian issues.
> >
> > Then allow virtio mmio driver instances to be created with
> > platform data and fix a minor endian issue.
> >
> > Finally, add the code for the board to create the instances.
>
> We get this in CI:
> drivers/virtio/virtio_mmio.c:359:15: warning: cast to 'void *' from
>  smaller integer type 'phys_addr_t' (aka 'unsigned int') [-Wint-to-void-pointer-cast]
>   359 |         priv->base = (void __iomem *)plat->base;
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~                                      1 warning generated.
>
> With clang, please fix.

That seems to be a 64bit cpu that has 32bit phys_addr_t
(CONFIG_PHYS_64BIT=n)? Would this be acceptable:
priv->base = (void __iomem *)(uintptr_t)plat->base

That would extend plat->base up to 64bits where needed and I guess
that is ok because if you have a 64bit cpu but a 32bit phys_addr_t you
don't have anything above 4GB that you want to access?

Cheers,

Daniel
