Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A24CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C41226061E;
	Mon, 12 Oct 2026 09:57:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 07DmxfVnYvw5; Mon, 12 Oct 2026 09:57:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 214E7605FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791799037;
	b=LPeYjOBETOdseU+Az0AQKVVEosTKYKx6W9HWj7GS6MPVIUyISxpXkDg21haqBDVSF2Hu
	 ih7W4ssEz0PQYk/DWKMKY6Ifu1xVL5z6w5BBXv3COQEWRqKYhaX59isqiBYnRSk4B7s0w
	 RF94x6s4AZzrTnvNyJHTSWcGwBHYz+ZxQIAVlpXnwwRAcHExbxJy18ScfIiyVfSbEb610
	 L+6KehnwltOSbrGanBPOf5+NJm5HbE1Qd3ggGZQuOISgC/ndtYb//J0prMoIVXK6nthns
	 agulGInHvaBnGSJzlZVu5sH583WQKTKDHz69VY+5LxmO+3Kx+f3KSvzNPoe6c2T0Oeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791799037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/tqbbKjwSdgIaGwTuGztz0EEbqJmkTnCChpYub2URj8=;
	b=fnhGvMATNMwx2VoSSBFSP3rTtUJK9sOendNOzKNM693furb6dzO4/XXL49sWlvDFTtyb
	 I1VJLc/7ddWiQ8bC2TyKK0zW9IWpaLrapXjUoD+Hqgrub+gvK57UAtE++diLNTCl+NV62
	 pIAOy2EQtT6MfycVeXgk1iBIQYM6sq3g0V973RZ+Ob0OmgCzTI2GH+xN9tLxATochZd+Q
	 yPBuowt0K0vCzHCJy/D+5z/53Xf4XQvlVfjYQqHLHW08b4qYdH3oH16N3g5xueCLP1rQs
	 JR1wHgP0JNMVBGZM0m1kmGfGVvWO4s2+UqPK3/8hv20qWXeiaNPxAPuTwa9A+sJHEcQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqMrW5sR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791799037;
	bh=/tqbbKjwSdgIaGwTuGztz0EEbqJmkTnCChpYub2URj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nlzjq26uhqFQCSV/eSOE5q4l8Ml/xzIjy3XXNXPtTqu3IseuPTgNwOElJjVonq6bJ
	 lbMULOHB7dFiqA0Gs3wuXw9I0GDxMrR5pvbKyv1bC70y8sY3Cn2h5U2EoRLE0OFdcA
	 Td2pYvo3qLvneesS1dvtOsoGeT45YstCB5UU/mSAzVH/3sb8F+luabL+nQZfuzYnWB
	 AqAvJl7Uf93QMmXzjO/rvkgDPa/yijAIv0dQQ+rJLJzG1NG0r8y8q7/rfMjsPx9UgM
	 V/ELn/EKkKh6krP159NQ0q40lZuEYyHwMzOiogE2/YG2M6UZn5ZqHNjQVAkPOKta4O
	 r7HiN4pIdZ4OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 214E7605FD;
	Mon, 12 Oct 2026 09:57:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 96A0F194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9412E605FD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:57:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tIGC7iVD4X7N for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 09:57:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F1A16605E9
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791799035;
 b=K5J/tVEOfxXmc9Xxqu/k/l2XDWM0/8WgXPVI4lANcE3qqtRzqm2QMmeel7Pb0edSZG8x
 NcWO7F4fGpi4wVbzgzFg0wMzpo79Vk75iN7Xg2Iks4d5TPBiQH5dW5m20yOlunHv4R2eZ
 NA6+xfbbLN1PAN99gUANY7jnyaV187eGEv6G/UcMG4en8p1PY+XmVT2AO4IKwHz6CMDCj
 xAfDxx9UI3DPPags3Vrj8UOpqDCLbuAN/dXv9bENuxBZJjqsHX8fGbOl+p+biQn53EI1V
 WUQV8lqQofCaDgk9HluRqZCLk8C3SR7LHSAlnZSZi9J7kyXRrO31LU7RsOL0XAOkmzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791799035;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=/tqbbKjwSdgIaGwTuGztz0EEbqJmkTnCChpYub2URj8=;
 b=TeXVWeoCwxR5XgL/7E0Jo5ktX5k8dTCCtaxNKaa0XuoNGfF9rolfEcz40F78aVA5Edyy
 KaGOlXU70GCzXpxCknGBk22x7nXTmSCOCqaBhc9Pczq4RaHR8e1mRXaDywC4Po6xdF+sy
 5b86m1mOux4s4EQcqhAk3SHm89uOGXjHw9vAzjtINfWroNzl2Py5yhKh27JQAGUbB4nuv
 RVG0mr9SgqiDTIArTJADmjwRczhV1kQZ4m0pZccq2J2z3WDo0VSe24grXf/V5TIoJ23FO
 p7Z+3GI1JF/7zRVCNqm/HaRHgmCeXWI6/91o0o9rt3i5IQ9gY75+shGMirS4g4XRR2g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kqMrW5sR; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kqMrW5sR
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1A16605E9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:57:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4590E600E2;
 Mon, 12 Oct 2026 09:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842441F0089B;
 Mon, 12 Oct 2026 09:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791799033;
 bh=/tqbbKjwSdgIaGwTuGztz0EEbqJmkTnCChpYub2URj8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=kqMrW5sR2IWNafhwMtkgkUMNF3BiC1hY58GYVJx6A0ClzjWszqFL+Givk5l9p67Yo
 S1TXGOK65fc9vEplX0jSnHSTUCpYYs1idBeuH6aPXc+c0tCw7+XYqdDGRmNrtxA79H
 L6cEbwEG6wbKHAl96NoD/H02B4e3I8LSB3hQnVge313TVppDwtWpz3i/FOX4soja86
 KrYWbQaCYnxQy3KzkH+cUETDsc6LOnBStN0cyLrz1T4/pPqvlGYWbDd2uXHB4h012Y
 mbcjtc5ASlOzvHhwgGKn2K7c9e6jwQVmxIjiFFaYEkaXodCjpGalgjgY9BTdjI8KO7
 ama143u1ZmyRQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>, Jerome Forissier
 <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, David Lechner <dlechner@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peter Robinson
 <pbrobinson@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, Weijie
 Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Alexey Charkov <alchark@flipper.net>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH 06/16] dfu: enable TFTP transport with lwIP
In-Reply-To: <20261010-submit-lwip-tftp-combined-v1-v1-6-cf8002c6f401@gmail.com>
References: <20261010-submit-lwip-tftp-combined-v1-v1-0-cf8002c6f401@gmail.com>
 <20261010-submit-lwip-tftp-combined-v1-v1-6-cf8002c6f401@gmail.com>
Date: Mon, 12 Oct 2026 11:57:10 +0200
Message-ID: <xhkdbecdv8cnd.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi James,

Thank you for the patch.

On Sat, Oct 10, 2026 at 18:37, James Hilliard <james.hilliard1@gmail.com> wrote:

> DFU-over-TFTP uses update_tftp(), which now dispatches through
> the stack-independent TFTP helper and no longer depends on legacy
> networking internals.
>
> Allow DFU_TFTP with either network stack and select the network
> commands required by the update path.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/dfu/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
> index eeae2fd65ad..1cc2595eb01 100644
> --- a/drivers/dfu/Kconfig
> +++ b/drivers/dfu/Kconfig
> @@ -11,7 +11,7 @@ config DFU_OVER_USB
>  
>  config DFU_OVER_TFTP
>  	bool
> -	depends on NET_LEGACY
> +	depends on NET
>  
>  config DFU_WRITE_ALT
>  	bool
> @@ -20,9 +20,10 @@ if DFU
>  config DFU_TFTP
>  	bool "DFU via TFTP"
>  	depends on NETDEVICES
> -	depends on !NET_LWIP
>  	select UPDATE_COMMON
>  	select DFU_OVER_TFTP
> +	select CMD_NET
> +	select CMD_TFTPBOOT
>  	help
>  	  This option allows performing update of DFU-managed medium with data
>  	  sent via TFTP boot.
>
> -- 
> 2.53.0
