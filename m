Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC15FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D783F84666;
	Mon,  4 May 2026 14:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NOMnNvw/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 620CD8394E; Mon,  4 May 2026 14:17:15 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07AF083EF9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67bb5ad91bfso5040597a12.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897032; cv=none;
 d=google.com; s=arc-20240605;
 b=XH3NNFfB9MXpsRIT5aU2HSfvIsUsqzoMOAVeciPE3h1p2j1HxoID+Hq+uZaSBtZSkv
 T2TcKHmVeegVxmj1/2NCpbK8sG9u57sN71Mq80e2h98AqfldFTo4WSyC1nN4buWp/i/b
 b9/49+5oHD0IAq/2E5g7b+zfFK3MBsVmQqMEkF4h/YLhY1mINNkFpsaH0GxvDTCft8+V
 cX00fyJ+BKPIM2nMhzuZ8LcOAb5csu1fDXgtLhMAtKl/XuGbrJflBpQeergEaZpLq+86
 oRo3fK5D7/Rrtjm2gOoIN4egTLfH0Pw2F6F+rdJGD8xoWScOPkrxLKQT8NJYFkqYYofF
 OGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=ZWqMSweWgtaIwk9pq1YqCg/BfTctVXq4Iv6cVbAuePE=;
 fh=1Rj5Iy6AYTVFICKN1ytNA1aIol2wPtRnCaE60wRA0L4=;
 b=lDwPLadR86KNWkhpVIO57Gu7cj0PhFTXsz3vngLD0wds9KOQ1YPw4OatK3M3w86WVb
 ruZUcTeaG0jItrhd5cIu7/8OKkP8I3xz17RStu7dRlPTQuHlacwH7PMkAM5ei6Xhgnmm
 R+3lM+WnZERoR/knA7VvlsqAmx5bePJsNx+GizVaMUf3PUbQeuh/3vzBfCQ/Wx5HH0Tu
 WYrwD1/BtNiCGElIVa+xSlso6es9zBsriGk7FVeP8A+DtgEUQC9aZfzKqPaPyDgpUldU
 pU1wr3xunemzcMpDf+X82WW7kWfZVg24vXjPTO++6/D2dJJfeaEvg8ibqK8/xPAzteGF
 GTSA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897032; x=1778501832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZWqMSweWgtaIwk9pq1YqCg/BfTctVXq4Iv6cVbAuePE=;
 b=NOMnNvw/Jy+KKziGHW66j69Xb/eD0oWHzMNFbg6EUHUc+a6X+PTK1XH8aLVMaee0Hy
 odQ4lG++sKvteroIWheiXRv9GMHUznXmQcgAZ5cn9NJw8yqJChJRWhg3u7wsb3B8PZ+5
 gCKUxsLrVdeQ8yN9mUyUfjLy79UeHlgo44nSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897032; x=1778501832;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWqMSweWgtaIwk9pq1YqCg/BfTctVXq4Iv6cVbAuePE=;
 b=Iinq93G1e3q7A5ZsdPncFPACgoGV5W5RUfrPTJ2J/JSCsDsZZ36cn6EvKO85CFr4LF
 hFs26BjypAk+nMliOLX6aQRmyybn6tC3+OUxMjWBp3sUMJnnQKZ4x9ZrKGSbDGaSFVnf
 WomR4aRmuQ+glPhaSU4bwOG0RgOfio2kObvttCz+pkhMI5csOwEQULFBURrv+7HCNRwT
 j/SNwNkMzQKTJeDmvVCzq4TsEdlAgRsNwa6wTZkUmgwRP3sjqoPZFzcKp6tMraBKtMkH
 BPbj4B4TFQle90sACreYk1X21hqXBdED/gJXoJnqtifCflDjTEBx0F21W1/9JL7GGU6V
 USeA==
X-Gm-Message-State: AOJu0YzUNAhMddfHlVwK2ojUXaDrOzPMq2+gkPKzScsgy1Vg4qPYhTyk
 JHAIcPd2qSjMOUmY6rrmhgL0hToLc0nLOUoqKJXRMxNE2d6QSzBhCYVXL+hT2wNe6x2f1IqEIw3
 Ylen/YipmNMrqRDIPED2T9uI4MPqmiZT+KeMIkBGDcYW3QaGvHQI=
X-Gm-Gg: AeBDievfmom3nxmy9n+CTmRcVz4q2Y54VAd4bUFz7Wtw9QOEJLh70H8/Zo2WGtiPaFy
 hEa8EWhY8Yfb9XlzAnwJwAk0noogz7Spf2T079rGfvE6Bpk8Yyft9SwQX3oud9YoC/5uukJ8WEB
 z4kHwT39aGDIJTVWYRXcvINIuSFm7SQw1qf6KcaEOnPQPTREH7rHR5o0CGUxpDerfj6PGKEGoKo
 JN1P7cwrw341W2UmNJCKRzVhD36nXaIWHnYQwzN2txXGH7naFTniBi9e+fAhFsaG/HD84+Nx7t7
 +cRwxGw2sf1SvuPB
X-Received: by 2002:a17:906:eec6:b0:bba:6214:39f3 with SMTP id
 a640c23a62f3a-bbffe1c329amr436514266b.37.1777897030311; Mon, 04 May 2026
 05:17:10 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:16:58 -0600
X-Gm-Features: AVHnY4KDoLx8_zoBwNey1x1Qu1_PMA-0YXVrgBkuh4yOKNmH1Kjh0CsMS8J_QN8
Message-ID: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
Subject: In-tree Python tools (patman, buildman, binman, etc.)
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

Hi,

As you know, I maintain several tools which are part of the U-Boot tree.

Tom has previously suggested that it would be better to move patman
out of the U-Boot tree, e.g. to its own Github project. It is a
general tool which can be used with Linux and other
mailing-list/patchwork-based projects. I have never been keen on
taking on the extra effort required, but I've recently added more
features and am wondering whether now might be a good time to do this.

Buildman is quite obviously designed specifically for U-Boot. I have
made some improvements recently (a large code refactor and distributed
builds). I would like to push those changes to mainline. Do people
think it should be in a separate tree somewhere?

Binman was written with U-Boot in mind but supports other projects
(such as Zephyr). It is generic enough that it could be separated. The
impact would be harder code review.

We also have smaller things like qconfig (which I have substantially
rewritten to make it fast) and dtoc, which is very tailored to U-Boot.

What do people think? Of all of these, patman would be the easiest to
move, with the least impact on existing workflows.

Regards,
Simon
