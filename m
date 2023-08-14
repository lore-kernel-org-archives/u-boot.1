Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422EDC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C4086977;
	Tue, 15 Aug 2023 00:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dWvwo7u6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SCPjD1KH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1653C86986; Tue, 15 Aug 2023 00:31:59 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4268686958
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RPpzd0yjdz9sRl;
 Tue, 15 Aug 2023 00:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692052317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EENBVWR/zGNU0on0IiPCGS0mk6fDP679oyJKJVDjHA=;
 b=dWvwo7u61VQfvdvqThRvEK232vCuS3UneJhU71SEWIwo06cemN6oOZAzXvEB1j+qNzWBlU
 4Y2K8nSgkhOTzkuKq/xpeaMjvYnXf67LRDWbfJxyn/5GAiqJSNbHLygfzJo/E5enVxd8NG
 W4L+UIYlVawpLso2B3jnDCqK1gw+gwC+/+DCpSFHZ0TZ54Da+tdhLC1YMS+lAZNaZObSaI
 qYrPZ7m75I3Br1z24LtcB2VFFjb6pWYaf5hDzYbhMBcl603UMxnMRgPrEZStpY1Xozzkfs
 CK2pvnSPqucbfZymAcqWyUMVrpfaMSfoc+DgxsBlU2gvK518CO1BVvfSilAs3A==
Message-ID: <d4b2b0f9-6231-6087-a06f-df7f059a80e5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692052315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EENBVWR/zGNU0on0IiPCGS0mk6fDP679oyJKJVDjHA=;
 b=SCPjD1KHhvYMe4mAKJYTKU3HI5svWfJwulSVgQMnO8Q1P5cWZo6UZoZEMrWjzQK/IQ4OTT
 v+oaXHH1BGBFqHf6Bek15p6ilJ0CMdIpCYtcUm6ThFyy0N5hP+1ACh424aQZyMxSQ8xvf8
 CZufz3CyAdgnotOPEuDUScHS7SWb6+BPcWrMkPUuF55mhRSU9yRkh6iS2O9HgpvFL24f7u
 i0+JhtTcgES4UPfp5u4m0SQnkGHN4oiBLrIKDuaO8Ul8wqDIJMBbBlT9CJM1Vo78DljSnP
 TIDyDCSfqlfPsKVr+mQwD/fDqxENlNInOta+O3LYJKIM3SaDmcccoYPtbU2rvg==
Date: Tue, 15 Aug 2023 00:31:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 17/17] MAINTAINERS: Update UFS maintainer
Content-Language: en-US
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.linux@gmail.com,
 marek.vasut+renesas@mailbox.org, sumit.garg@linaro.org,
 rfried.dev@gmail.com, patrice.chotard@foss.st.com, jbx6244@gmail.com,
 kever.yang@rock-chips.com, eugen.hristev@collabora.com,
 "vigneshr@ti.com" <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
 <20230814215457.4075025-18-bhupesh.sharma@linaro.org>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230814215457.4075025-18-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 18cb825dda4333974df
X-MBO-RS-META: 4q7snwyftg5brnqepsorpfpfep191x4f
X-Rspamd-Queue-Id: 4RPpzd0yjdz9sRl
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

On 8/14/23 23:54, Bhupesh Sharma wrote:
> Since Faiz Abbas's email ID is no longer valid,
> drop him from UFS Maintainer list.
> 
> Since I am using the UFS framework now extensively
> on Qualcomm Snapdragon SoCs, so proposing myself as
> the new UFS maintainer.
> 
> I have also been sending out u-boot UFS fixes in the
> recent past.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

I believe TI is working on something here, so please coordinate with them.
