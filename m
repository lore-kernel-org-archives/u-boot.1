Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355DDCCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9834084562;
	Thu,  9 Oct 2025 16:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TnEZ743Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C192C84523; Thu,  9 Oct 2025 16:19:08 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9701E840D5
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-43f47280160so621474b6e.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019544; x=1760624344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GeBoU+iWdh/b2GDzku1V+uW4QIBPDEEZqdV4jtqgwhQ=;
 b=TnEZ743YisqJD0lJ9nNVLgHP8/Jy/wXTAHeKQrSGitVVMS1hmO7Pl93Sz7gF4ponSK
 7cr18JMtBOq5LN01unRXjcHfckDR3X2kb25sISs4cSSqZb0k+42TYLvAQpV2nInqGOfU
 5LNvY72g93pUNRL1L0B72nRl+SDN1kf87IMSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019544; x=1760624344;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GeBoU+iWdh/b2GDzku1V+uW4QIBPDEEZqdV4jtqgwhQ=;
 b=o3VQJ0qX2FQCvU+cAWT5XbdrfpLQ+9VSviY4KpVdh09LsVLDFLJYKNF1HoqDMIzSpL
 qlh8DNBY5faCHyRAZQnC0ya+BCizvHbVI0VEjp2lnrRhIDPgcWvlAv87jvhWh4RTRnJX
 +zwuyC0PqNTjCQEd0/3q+6ZZf6EinhLh/+wvhOxexMJXwKToKDW6IWZvqkPazkyXu66s
 hDPLkMHAygwg5m2lqAEZWR8vXwvTAC6Eut6wWkdwVjUPIyET0N3M3yOKiJqDw3PoHCQe
 CZKJXHxOz40SXZb4l2WrOjbFXk+GCNaTm0AiRUdzk6TvEuWtu8SEvBQzhUXIJ9HGwh83
 F80Q==
X-Gm-Message-State: AOJu0YwBl7lBfQdHrzhK5r8Tr2hgAL3iutyNExUIZReOAiXpXnMDE9mo
 8vbZrHpCze6FWA3MKn4PisKc+Y8DXF1sMlWzLFQG8BBB92YVx0WfoWGZA08qD0AfbSfBLXJjfqr
 uANQ3k6E=
X-Gm-Gg: ASbGncujNH1nTrpg2by+qMqhHct/tE4mk2xMMzU28m1e7vsDHmLE1buyMcPib2IX+Zu
 eI6cIW+pwJEeX369PfytPwWwjRNaPAKiJpcXVnnE+8RabKSTq0VR8Fy7SokMpuD9dZkjPEluJdl
 Eh1txHikxJdNfPzTY5rUABFR0R1z1zETSXRXQlPIWHvC574p35TBAElSs6O9S71irNpHCl/z0op
 50zHASL3hj1bqY115Nd/OpyMxZUOki1R+5wJ3hnpu9ncIb2VQGx9fLT8N9VyhRB1A8tL5BsUcmQ
 n9NY7CCeX+Ql9qcqkUrTR+PiyQYLbsh1VYCMHJVDvlThJ1Bibgb6NNdK9heDL4VKQOpeB4phQdi
 HlMOLn/viv4lLlcaVnS/iiapiarGj2KrqALYPMa/BTqwi2e4CuFPAHeycAtFDlRaWhxkPB2ALGG
 aFJGXnjfKz
X-Google-Smtp-Source: AGHT+IEAO24I4EMvVw1HM8vbs4KNdSUMtvV6FAutFNGKhnvpZlmj0+6Ba+DxhlnjAPla2dfjvZ92/w==
X-Received: by 2002:a05:6808:189c:b0:43f:7287:a5df with SMTP id
 5614622812f47-4417b416fdemr3554970b6e.26.1760019544126; 
 Thu, 09 Oct 2025 07:19:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:19:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>
Cc: thomas.petazzoni@bootlin.com, Hendrik Donner <hd@os-cillation.de>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250929172434.1034898-1-kory.maincent@bootlin.com>
References: <20250929172434.1034898-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH] scripts/checkpatch.pl: Resync with v6.17
Message-Id: <176001954319.3159859.9221993956774349475.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:19:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 29 Sep 2025 19:24:32 +0200, Kory Maincent wrote:

> This resyncs us with the version found in v6.17 of the Linux kernel with
> the following exceptions:
> - Keep our u-boot specific tests / code area.
> - Keep the location of our checkpatch.rst
> - Change the "use strscpy" test as we don't have that to strlcpy
> - Keep debug/printf in the list for $logFunctions
> - Keep checks to "env" files
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] scripts/checkpatch.pl: Resync with v6.17
      commit: ddde9ac63d71a4336e27cb49d011b67c7e5255c5
-- 
Tom


