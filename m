Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3011EC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D73687C6B;
	Fri, 15 Dec 2023 19:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVbm7xCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AAB087C7F; Fri, 15 Dec 2023 19:37:32 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E40FA87C6E
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-425fbac8fc7so7555471cf.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 10:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702665447; x=1703270247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiNtBwTLrLW0vFcXQoOfn06SZjmFw5tzk2tqRzOU+/w=;
 b=jVbm7xCSp1veAJ61ocbp/L8J4p1/qivCVJEG7QrTXXnsqnFyXGO1/xMPSwP+/s+5hH
 uoMAkikXpUbgJfyaweyJKPgE5UXF0qcwVxzZWN1c5dCk0AuU65vSFsvUJ/fKFdFlb+Gn
 SFx4JPdXUadAh9UT5sVb/aTwdSSNjV8tuHhTDOJNupwEcPb1HmsBaN6Mdqp+81ILVuY8
 tBz1R9G4q7zCNX0KbiUptfF1jSBZkeq8J/Rm2z/p+If9iFceBXXgQlbURNIXOw/uIU4T
 R93DqJYdc87q8ceeoZhbu1+YBUbRWwavOQGJbZ42k8Ncdo42OPJj2wR1hB7CJG3CCd/T
 cNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702665447; x=1703270247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JiNtBwTLrLW0vFcXQoOfn06SZjmFw5tzk2tqRzOU+/w=;
 b=E6kPPGH6wT/iXfAgxqg0jv7z1kj3qWGjcTzANXjtubkh+MJLBWLEqzT+x/ejbjS+Cx
 VWER3bzaEwxze+JadsKCrdLCAP17OFg+8zulvwVNNeK3zIcnbSXErR+Jiwy14DGQcfPz
 XQs1B+NUPTaWQU9zpQIPVPIpHG7Lj0XqBObhS3XJGXojjiDqD2yZOfZfqlWA1G7+5r0s
 UjS44uW0tXfn0i5+8Ca2R7xpYvfB3xsPzVBXx3unYsuBU7nzQIYgG19XyEMjWEhCkyY0
 V5+Fa7NewDYIZ0AYbaER+NPanHM4uwLZ/rJH5doC3KnoMvJ/MfZ1m3f6QKpSPEt2y3oM
 kjnw==
X-Gm-Message-State: AOJu0YxcBKVphZKTfABKylJpG3JHPCcb3KAQciyWp5U5qNfWeaZt3oME
 EQLk9e2Hlb3cbWxs5i6CEbA=
X-Google-Smtp-Source: AGHT+IH+6FEIFHWrTgFh16Jnq8eD6iz6nzZr7CMbnK39JAq4gAe5mdC4FqsTXthnMS8R6F45im/J3g==
X-Received: by 2002:a05:622a:5c8:b0:425:61d0:92d4 with SMTP id
 d8-20020a05622a05c800b0042561d092d4mr16564492qtb.113.1702665447756; 
 Fri, 15 Dec 2023 10:37:27 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 o15-20020ac8698f000000b0042388bce404sm6887671qtq.57.2023.12.15.10.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 10:37:27 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: forbidden405@outlook.com,
	Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH v2] clk: check parent_name in clk_register to avoid
 confusing log_error() output
Date: Fri, 15 Dec 2023 13:37:23 -0500
Message-Id: <170266540039.2383564.10933966436494208688.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230807-clk-fix-v2-1-0b688e21fb4e@outlook.com>
References: <20230807-clk-fix-v2-1-0b688e21fb4e@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 11 Nov 2023 03:19:52 +0800, Yang Xiwen wrote:
> For some gate clocks and fixed clocks without a parent, calling
> clk_register will print an useless error message indicating that parent
> is missing. Fix that by gaurding log_xxx() with an if-statement.
> 
> 

Applied, thanks!

[1/1] clk: check parent_name in clk_register to avoid confusing log_error() output
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/09844d0de555

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
