Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4B5C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 08:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0353E85B66;
	Thu,  6 Jun 2024 10:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lXpKhe6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75CE487D9B; Thu,  6 Jun 2024 10:24:01 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B1E8332E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054dso508640b3a.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 01:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717662237; x=1718267037; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UXNYHMWcwj95zNi2EgCuUxq2SX4UUpVVXL47aOL7OYQ=;
 b=lXpKhe6RZfwpYv5korcg3nJM8zJgcT2aQRyDN/svEKtQbzuVoddR2rL+J4AM04TTps
 qvG9x+4x8WCLYrXyLKNCcnvwH31BdJqdMTIY16cWQ0wIyJzSSyoa+GUB/O0sRp4TSPqy
 2FjZysD6yJ7mT/gqhIM4jq0QA2jrdl7BkHa83HF2Aia9d2xS1adIqDcxzVwLBjPzcCTZ
 CrGzQKbhEpmOoOwxL5h9VgOPrhshPd9UfjasC03UgRUsWhOflhNwP8GWk9rJQ//6beUH
 EK5igNAqNe7DDWW6Z0v1qoeiD/kC1n5oy9Vw7SISAScS/ONih+qzEs2LiwbuaAJG1mHV
 7TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717662237; x=1718267037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UXNYHMWcwj95zNi2EgCuUxq2SX4UUpVVXL47aOL7OYQ=;
 b=OXWLAEDrdWttFLkXhQF+oOK2PN5NBRVXz9Lh4z+Slyel3SJ0yDPQ6Bo313T1N2q3KQ
 rMyHW5topqkrHQvQFWQt37huIKpCR98vnjCCUw13Wpr0bjsrbzJUx1urlxEywWh4FAJV
 WyB2ZZBq+wPtSTTIUJzJJ2o0dN9QIO64qj8X/mSwnKYmUP1U1Ck2xpPs+4AzPrusoeYS
 acI4tWLV0N0MJ1v5UzCuVgpMvf1uWSQIJ7zLG5m5HgAxNAvLQAW1cV6w4cUpy6JIlJzO
 HYSUfIammoXz/RG8kSZJinvaNARb0NykvzUGwME41MxBO61X+toQUV56qiiihxOVZ3x4
 inqQ==
X-Gm-Message-State: AOJu0Yz9IOtHzP+S12ZyRiNwMwTTTB1WO7WT2uruqzU1k83q7juGs1zd
 pXzbVfEKE7NprFz1XOqZH0B982238tyRTuLa3K6IuhLXUCiVQtdh99RwKcDtSSzhDcFypSpyD/f
 /tsCWuBiHCHc/SFBA7YI8hAZduyRKdJf3WzNkyg==
X-Google-Smtp-Source: AGHT+IF86XzJ0uDDWMDrh/Dr+uzeelkWL4UUmahXFazbrJA2PQW+20BjQevRKqWVVloUhAcxwAZN3FFHpU4TfT7s7J8=
X-Received: by 2002:a05:6a20:a122:b0:1ad:7e4d:2ea2 with SMTP id
 adf61e73a8af0-1b2b6e2d014mr6077954637.4.1717662237126; Thu, 06 Jun 2024
 01:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <4fd96b9f7312793109fe32a85fc717566ef6fa92.1717655740.git.michal.simek@amd.com>
In-Reply-To: <4fd96b9f7312793109fe32a85fc717566ef6fa92.1717655740.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Jun 2024 11:23:21 +0300
Message-ID: <CAC_iWjKzkx10FZN2MRq1r9Gty-pZRYO+LtG5Lzmu-7jjQGMshQ@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: fwu: Also print information about size
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Etienne Carriere <etienne.carriere@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

This isn't needed v1 [0] is better

[0] https://lore.kernel.org/u-boot/6ecddda9-0823-4512-b33c-787eef615181@amd.com/

On Thu, 6 Jun 2024 at 09:35, Michal Simek <michal.simek@amd.com> wrote:
>
> It is useful when structure is also used for saving vendor data covered
> by CRC32.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - print it only in mdata v2 version
>
>  cmd/fwu_mdata.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
> index 6d91935b9b54..56654ba1b93c 100644
> --- a/cmd/fwu_mdata.c
> +++ b/cmd/fwu_mdata.c
> @@ -27,6 +27,7 @@ static void print_mdata(struct fwu_data *data)
>         printf("previous_active_index: %#x\n", data->previous_active_index);
>
>         if (data->version == 2) {
> +               printf("size: %#x\n", data->metadata_size);
>                 for (i = 0; i < 4; i++)
>                         printf("bank_state[%d]: %#x\n",
>                                i, data->bank_state[i]);
> --
> 2.40.1
>
