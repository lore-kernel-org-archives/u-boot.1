Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A43C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 20:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3250882F8E;
	Fri, 11 Jul 2025 22:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WsgtBTXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE30F82998; Fri, 11 Jul 2025 22:00:51 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7011B82C84
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 22:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-611e20dd2ffso761586eaf.2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752264048; x=1752868848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flgQH+kl+Dn0l6pIUktwWcmqrD0qr9+BdwqM40mO3P0=;
 b=WsgtBTXqGgTZnADK3GHy3j4VpK3vLZGXAg3+9id1ATqPt0yp/h9c56qviIm6ZQfk22
 tRmqTfMV/IMDSno3TC5YhQim/D/5opXdM2F1AfYYWeJpxirqSAi7DekVtUpB40xcoGPt
 UAuEwyQX/opbJy8pGaPFTqexR+AGy7lnZEyQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752264048; x=1752868848;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flgQH+kl+Dn0l6pIUktwWcmqrD0qr9+BdwqM40mO3P0=;
 b=Kg+fKE5hUSoZQZWVnbqRA+6scUaVErwf9HNqHY2rz0yZhk20SPlCwNwE7tgkxfQ1Us
 WyC73pqYhtA1pfMLZiNwhBB6WQQvpYyN8Y6QELD1rrDMbs6vNotPQwN2skdqfif75oDz
 DuiQ5lZqvisKqEvNuDz3TzDVTwFJ0Gm+YKVJZy5idDubB4kgXht5fG1x2JDvKC56nHBf
 E7wFuLvoizFTEu65tL/ulLivYMa+sFJH/lG5KvPoKN6VGTTd7TZ4Iq4xqD0rKLU355oy
 3wFfFQITqKyFXUDP461p2Jp/n0D8UpnWs/uuN6NwAC+ADP68FrO6YqnDSI7jJS7TsUpm
 I7VA==
X-Gm-Message-State: AOJu0YxCyjEzn+CZkkostUlCMcUdZ625yKp4nYr9LwjcVd6MVdezUrpg
 vOoVFy8z7qHqRWE6uSVqlsgAINbD3kTZ0uVox7Ht9e6IOjuU5UDVDGhZcJvrEKJOuFg=
X-Gm-Gg: ASbGnctZDeI4yuALsgked+TyrbbyZM82gMclRaRSEgvEkQpanWAIF11LVN7s2Alp/5s
 cVaa9ohDD860FHD5epLjz5gHoTvn5ZIFe9B+cr8EAxyzgfjxwtOqkrqkXOshPiksvwwyS0lFB92
 lZs6WOBHKynhrT4vmyD6GK9xbkdEmsMpoZzKEbIdaNUcT8dNntIm3fNgluWrkt8HJy+qpcvCprT
 Dk9MjhZn6Wpaldr9izP4JNdjECr7Qp18EJsRX+RfF0cJbK51b12n9QIu/0g1p8ePmdJv5Lab6jL
 TaiJeKK4AjPmmsK6b3j4l5WGJ5kBC/bHKL4LdaQ99DytAsDhTnHuAhisNlryN2H4zxbtYPq5ZVn
 h609T2IuxQt2vevK8EwReioQ03H1rMDywiwCKFTWTINzoqClJ4wkzTAPmOSasJx3f8w==
X-Google-Smtp-Source: AGHT+IE0RNMgq8u/04W4IG29Dfb7pYAbRCUmafLLYnmpwBkpv18BpgGmd7KkdNLWXT/W7RoxbsVMpQ==
X-Received: by 2002:a05:6808:4f28:b0:40b:3530:98bb with SMTP id
 5614622812f47-4150db3262cmr3576378b6e.9.1752264048077; 
 Fri, 11 Jul 2025 13:00:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414161e2b74sm666516b6e.0.2025.07.11.13.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 13:00:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>
Cc: vigneshr@ti.com, vaishnav.a@ti.com, j-choudhary@ti.com, afd@ti.com, 
 u-kumar1@ti.com
In-Reply-To: <20250704091234.3218906-1-n-francis@ti.com>
References: <20250704091234.3218906-1-n-francis@ti.com>
Subject: Re: [PATCH v2] board: ti: Clean up formatting in rm-cfg.yaml
Message-Id: <175226404718.2365211.11325637132607693906.b4-ty@konsulko.com>
Date: Fri, 11 Jul 2025 14:00:47 -0600
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

On Fri, 04 Jul 2025 14:42:34 +0530, Neha Malcom Francis wrote:

> Move to using the latest generated RM YAML configuration files generated
> by the K3 Resource Partitioning Tool which updates them to have standard
> formatting with respect to indentation.
> 
> These files were generated from the untagged commit 41718bd5f915 ("docs: Update
> docs and move them to docs folder") of the K3 Resource Partitioning tool. This
> tool is packaged as a part of the public SDK and is not otherwise
> publicly available.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: ti: Clean up formatting in rm-cfg.yaml
      commit: a21ec39944f93fb5bd3dd5de525e78cac988fdb6
-- 
Tom


