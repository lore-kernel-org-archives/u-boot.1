Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2294CA5FAD
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 00:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 185978106A;
	Wed, 30 Sep 2026 00:43:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BT_xnKZTiAyC; Wed, 30 Sep 2026 00:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B985281029
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790729007;
	b=hQzYsx+q8bwu0HwdTyy6+pQN9dGX1ZfEG5uhOfvWh4C3C1jDPzHZ+o0jyw7QN76PGvV/
	 M4E5mXWd2s4siC+qstVQb6UeaLxumH3/VF5ZxRMiA8ONsnAS0fKTIubbRBgfJmGdvCUXm
	 YjJ3eUgdpE5G3lleNbXJDVwXjGt6FoaML0r8F/kidwDLped1R3C0ZJyRmdiqqffH1IgNQ
	 +LwrciODyb0xB1HF3esYVhYq+r8wDVdmBd9Ehg1Sqfpsi4s+BhpBIXOGny/O4hwRR9b9G
	 EqDVIFtYQEpC48jZLUjIIJ/ZOK4jUBmZauzmM6wBP7i60MXhZ8cbBomAEnp4XuNrkfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790729007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gSpAlHQ+rl9ghxmlNume4KDlCTGGUFlrOM5gGiKXTe0=;
	b=oNPrBXRu/WNlauNe+OiEEYPMwDR/npNeSy61h9CEae8z9DWhjNMo7VuadnQN80atDqMN
	 N9024Now7FTAPGl4vOFOK1EMKLPN2BHNySZiYuS/uUPBHSmahTB+j+E6qSsRa6fsjrQ6G
	 torV5aM3tD7OCkz0Zx+yet6aXSNhl5j/zLqCuM3NNZttetQGf9VgOuipGY1J68CPVCkuB
	 IXMajoA9Fphkd4nQdU4JuTth3zRoz5W6/Vj+8PuS7xYTggwD5DgAqkycEuXqWdHzpwHfu
	 SaO1jL+N1OwFxjq5tBG2xFi4EdqcRetOoMx+ELhWmEgD9/PVpd5z4nnD2c0vVTtVmAA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790729007;
	bh=gSpAlHQ+rl9ghxmlNume4KDlCTGGUFlrOM5gGiKXTe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=weXsLcIVL/jRsBOJebncyOj7pH4LKqiwgH3ZCjwBJHdQrdKPw1sdVtJeTdcavErKU
	 lMwetI/MwrZT4ZzCgujZp68WyaMEGjpb0yF0y2IUkSjXs6b6FK5pRP0GhnTuutBaic
	 5cH064mzvwbP3jAwbTerdn/DTiyzhCHgnF4AlQ/UdtFT29RyXkRHMtlFnKGZXuiIPc
	 P8uZXJNPXzQ/kiM9zYnYs0MLL9qITlRdv0P30p+n3RYeQhvCLqWLrZJOti/yq8EUW2
	 zEZ7gr+4QAmK4KYOszBIWInKw/ObwSYVwZWq/DJqY++Qgz4bPx7rn9wCd+Dmrbjpod
	 N+ruoH7zBH5Mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B985281029;
	Wed, 30 Sep 2026 00:43:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E6B632F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 00:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83FFF4034E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 00:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NRfhwjmuNxSf for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 00:43:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 05A1E400AE
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790729005;
 b=NlNi9AB5ZZiKGO/9M5DP+dLn3wj8rAAHvKHRRamx5raL5ww961QYhdVpsRhhb+breHNQ
 TkzPB7+5vWJKfxCT+PyeP4VQIZn0cdrETSYEvrCZ/XJDgvji+Cb/aYMBFNRYKkRfY4FGR
 h1kl0NcyqJP2vaUjr7EqORk5BtlmqKRdIU5P1iKMpWswKT9UjAQIxC8D+1FW3Z60B4M+4
 E+RYzw6Nq5kBx1fKFwtjeL/Hs6rbFoDcLW7OHzhzSfgdlUiTPIKcUtA6h1gkLihDD9bGF
 BRSTK672oYqj0V2dxbge1LCRNESQ7E5hWUwcIEbHCeUngje8SvVp3vNlrvtcPBSQ5HQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790729005;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=gSpAlHQ+rl9ghxmlNume4KDlCTGGUFlrOM5gGiKXTe0=;
 b=HeT9pgnYgEcw9ViIVjzNqTUNKC1yXiE8oDR3LNF88k2arTamuxRvLYgJjNpVuvzVP/I0
 qXORhcr/b5Fr7fj/ijpFx9KXXbNgZl4trPklObnPGcW7feCZKw7aqdS6TxpgHxeg/rRVy
 gsqRd/wqPldOmfT7/Gf2VN3drO81vcTD2uJ69QFzzA+VfPyUWpy6BJk5DjAHMjMQ68SkE
 UdmlDChnrXpoZh05HyO/aBArhEEu2x880lLSylIPaTXNySDOd9YT0iW31VZUqJYCVQ3WW
 5Eh3o08txzaZEVFitj4fmVJ+P6sTZUvmsOgXhlvXWnuMcC1Ce0cxMk0dWJTwpz8s5yw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Vf4iJAvm; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Vf4iJAvm
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05A1E400AE
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 00:43:23 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hvbr758PMzMlNY;
 Wed, 30 Sep 2026 02:43:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790728999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSpAlHQ+rl9ghxmlNume4KDlCTGGUFlrOM5gGiKXTe0=;
 b=Vf4iJAvmCYMt1fbaauHGKb+GtgdFTKiTAhP2L9DDlkvh92pV/rOo5kF/XWoj7irPagO78i
 52Qtbm5iPVHcV71E5DFzS9OR/H+5IVsy2dzgtcGXDqPV3zXb5VhN4PT2KtUcnaGvGimZW7
 CoPkiasYjTNdTCkKMwzG8oevI5s5cHffWMd1iVK+WPaUYO4tGqVSa/+KGVO0kV5/uHFfjJ
 nMFDhUG/DiiTk5te2Zqlt/6s5sn5krO9OuCTeKo+e/z3zwfMdgh4+2Xlb7rgpZfzWOuF5w
 6z6ppHBk+eZDw6evXWAl4JlIUgmAJ6c1fcbL0+HEGRG5xbEzY1UI11uas1AUoA==
Message-ID: <bdec8558-0408-4efc-8a50-e726c8be9cee@mailbox.org>
Date: Wed, 30 Sep 2026 02:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: Add StarFive JH-7110 SoC as requiring DMA below 4G
To: E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Liang
 <leo.liang@sifive.com>, u-boot@lists.u-boot-project.org
References: <20260929230758.616924-1-e@freeshell.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260929230758.616924-1-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: tfp315s6o87sgoimeqqqfo8cxp34rbea
X-MBO-RS-ID: 4eb90b7e43636c54eb9
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/30/26 1:07 AM, E Shattow wrote:
> Platform drivers and hardware for StarFive JH-7110 SoC are not capable of
> DMA access above 4GB

4 GiB

>. This was previously a problem for MMC access then
> resolved by a workaround, since reverted in a3075db94d49 ("lmb: Reinstate
> access to memory above ram_top"). The symptom of this is EFI boot failure
> of GRUB from EFI System Partition on USB MSC with a starfive_visionfive2
> board target that has the on-chip Cadence USB, tested with Pine64 Star64.
> 
> Restore the workaround with a dependency on LMB_LIMIT_DMA_BELOW_RAM_TOP.
> 
> Signed-off-by: E Shattow <e@freeshell.de>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
