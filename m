Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56821CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 12:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CDDB82A9E;
	Mon, 29 Sep 2025 14:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g8D+w4C6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BS+R4SLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D5BB83071; Mon, 29 Sep 2025 14:13:29 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BBE8206E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 14:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cb0TL0ygnz9tgD;
 Mon, 29 Sep 2025 14:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759148006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1oiR6D4/FobXapnVji+ZAUOmQnFSoCc5TjswEloAmNI=;
 b=g8D+w4C6mvB17c9atBWltgFgM0LlEyjwrRwN/+8Afs6Px/h9sVVs73+xKIn0vYt9+jeFy5
 2sUh1VyriQBd8tjkzW4OOfRULZr8Iu2FIfQZLpVAdGtISy45ACNUwhj4zUyH0gnptDiGPY
 ce0NPskSlLFDQmA7jhm+RCyXetz0qs6auhB4XAnMjCltsTkgp9HooVaXgadx1gRDUdYEt5
 OyQcYlBxSXPOswykUhsC8JUzBjdLbhUqjAv0q5nXQ5OOpkMlrAJkbb4ir4wcL3qWLknaka
 9wSbbUJQzBpa0JUqHn4MJS41SLzXj1QPpgn3k1H5mnc+Z492ANlwg43vTmanGw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=BS+R4SLK;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <7ab73b44-8efc-47d6-9e6e-5ffd9ab0e3d7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759148004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1oiR6D4/FobXapnVji+ZAUOmQnFSoCc5TjswEloAmNI=;
 b=BS+R4SLKgkx24+CO9cG/J2vSS2VJJ3H5iqWd5hoUXH8qo7UIKajcWjr7HsFdNOElyb3dxn
 0pMyVIqBeKbp0Y8l+T1gwFffzh3z8Yc7Uzlp6jpuAbiSY/cwopDMQbslB+jDkBjfPThIvi
 NrLePi39l0DSIAgep0SpJiRwob2W9nVfxMy4disuJXI9/il0BhZk0yuvMDT3YTQPFuAVrc
 /ctm5jR/rQe7gMbsSOeyaZhXnvPk9l7PKeEzZhc9TYycSHeBejBNKxBY8Bm5QobqdQQYZR
 9AzyzzI1rBpkg2oGppA2y32miQ4Xl5oFcZzJX9SWIDKLom/BEa+PaJicMgrgrA==
Date: Mon, 29 Sep 2025 14:13:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] xilinx: Enable sntp command
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <8259ca2496dd8f6a25df566c43f16be019d75cb9.1759127081.git.michal.simek@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <8259ca2496dd8f6a25df566c43f16be019d75cb9.1759127081.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 672a4f3845be78d5636
X-MBO-RS-META: fa6frsiw4ijywtayjbwwcpxfn7q39row
X-Rspamd-Queue-Id: 4cb0TL0ygnz9tgD
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

On 9/29/25 8:24 AM, Michal Simek wrote:
> Enable SNTP commands on all Xilinx boards.
Look at #include in configs/ , that should let you deduplicate xilinx 
configs.
