Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874EECDD0E1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FED8904B;
	Tue, 22 Oct 2024 22:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729628613;
	bh=Dz76ZoWBUSMgS5qBaWW+o9iHhkMNVeeWIAr1YNVpjc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ylW7ybTgcNGAi2jK30nNzXn/dMlmRsr/WOVeCRbXYbqE4EApPv3v5sMzCCqwylImk
	 q5esJPOq0+wqKRQUCedW6FQfwtKrGWT3gwIG2mvG1yhb9Jic7iYno5hjPFTkNDW+Up
	 4sSukbAD3mb2QlHpSPyBdBxCyAAucxgtd8mmHyJhG84XdQbcaBlv8DlTv94Gup6xKo
	 +yJXu816cvRMu7EUBZxygoZ4M1C11gqbsD+PKL0E9K6B1POpGgoA5vUtrPefA3GkFu
	 SYhcfvW1h3MUhZNepzLL58h1f+pC5iwzX8xXSSsu9wJDa2RuGSf6OhZCwsHrfuvGrK
	 dy44kbG90P2oQ==
Received: from crub (p5483347b.dip0.t-ipconnect.de [84.131.52.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EC6AC88FD9;
 Tue, 22 Oct 2024 22:23:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729628612;
 bh=Dz76ZoWBUSMgS5qBaWW+o9iHhkMNVeeWIAr1YNVpjc4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=yGd2dyG1lADdPznx7EbwT9Ao2jtT44d99vej3rsTnnBFw8Cou+I1szg5YeaE085VB
 9FBEVdw8WIfpXZ205F2tKA+6rv81R2Ry7fWt8QilrqY9l8rWyRzWsMgP5NYeRtv6hm
 /qDhZ74LgRlRuF5wNiBLZKVCBBfYpVmCIlhm03HPyZXXAijUbAXLPCkngfXM1EP8BC
 Lkd+9snvTxtN8fwTLGpb3Ug28VK+7OJvd6cqoPFvExX4NoetXr+MLcB9x/fEzFztGi
 v23XoG0ClQJ39/UwcP2sXsyFJDDPMgcJTF8se7nkXs8OvrdTyK1GXizhaLeAuigDUx
 ifKD3+sizpC4g==
Date: Tue, 22 Oct 2024 22:23:31 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: <u-boot@lists.denx.de>, <trini@konsulko.com>, <lekkit@at.encryp.ch>,
 <pbrobinson@gmail.com>, <caleb.connolly@linaro.org>
Subject: Re: [PATCH v2 1/1] video: simplefb: Fix build warn with
 CONFIG_FDT_64BIT=n
Message-ID: <20241022222331.609a7539@crub>
In-Reply-To: <20241009084828.864091-1-ycliang@andestech.com>
References: <20241009084828.864091-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 9 Oct 2024 16:48:28 +0800
Leo Yu-Chi Liang ycliang@andestech.com wrote:

> From: LekKit <50500857+LekKit@users.noreply.github.com>
> 
> Fix compile warning with !CONFIG_FDT_64BIT by
> casting the variable in the debug print.
> 
> Signed-off-by: Eva Kurchatova <lekkit@at.encryp.ch>
> Reported-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
>  drivers/video/simplefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to u-boot-video/master, thanks!

--
Anatolij
