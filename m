Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C43606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RQzzGi80;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HgxnlSrP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5017260A7E;
	Sat, 31 Oct 2026 09:29:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nMNG80dy2HOF; Sat, 31 Oct 2026 09:29:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F4D760667
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793438991;
	b=ZiyHi23++vLSdUWqdEX/HXoGFKbLvccku8eFQaWjZiD3pXUOmdhUuB9M3d4g7yWV1cHB
	 2eOrqqNu3oAt/23fm5vrJJLc9qWTmyIF9WJmRMedKXkBhEEqZk0m9PJuUBeIL4ucPDJjd
	 tJMD6WctZtQeqsvdHpChyX6UhuCCQSTbOtlPyVquuTdOYcFGLCI/Wtri4y4OY0CXkRyyg
	 +e1SQ/HDw0V3uJl4wXU1KZuu0SBgCUdrqixv5wih/5frpJPMDuHwaPb3/ePpJPa0nMtfQ
	 G1SY7ekiI+ErhNNzjq6xYuNGYAYHOM56uD+tyTu+KCqH1TKM2SgJN+tDaJhAvsmaeWw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793438991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5pMDcyzku+X7q737GHnrwaxUv/PxQGvEwpQ+fO2Jq2w=;
	b=ntPH6re7LVRrf2/dd9b6SvU9o38+FMazFLoSSiLH/38RlEwXk+bU6GYQcM6/7fhVhaiF
	 5rDUuvTqRGDzh6j8rj5a3ypsyuHnP78LgAoI8HudB132wZNGB+gU2/9YG1IewXQCAVWoN
	 zJxVMJnBOgXj+uaqTbxbPyCHO6bUDRyFshfowLw6PHcr4Bf8fd0J0CzZNBF02mcWzI/pR
	 eDSTRJPxzB3f3YO4FSuUv5tbiVYa47BylwhNJ7ofiQhFvyVKxA5CjT0/Iqq2/BKJJstzc
	 7eIe4gKZ/RZ3AS8ZR2PsZ9huM8GvugGjQ4QQJ6CBe/xxi7RiFg0g3koxsnMK4POCb1A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793438991;
	bh=5pMDcyzku+X7q737GHnrwaxUv/PxQGvEwpQ+fO2Jq2w=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RQzzGi8053if/PoN5zz8EEmSH/Q3WBNW+mvi3ZrLVGPnMXs0gLTtolee0yuY846fK
	 rd0Cy/fXWZNz/m871mEJ7Un0jP/d/7SYwc6bC7izP34zl/+7pWBYXzqKm6qKr8kcaE
	 qs962/QQoRCrnXDXrxq0Xp7g+iGkiSFvCTLQRCoekbc7qJwXQSOH6J77q74dmgsbYk
	 iYt5o8KXXUiqaFXPhK/IR7tADDCW1bCJiu3ryIyzQAYHjDwmASunth3edwVVeiZnaF
	 dq/LoXLkxjhcN4HXo+WppgrYW9fuXYaARrS81Ce6CGZ4hR2cXG+Oq5CewRoAoHcyRd
	 iigA0OBxxNCzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F4D760667;
	Sat, 31 Oct 2026 09:29:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5547F2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3BA3640B33
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XJg01JITMcKl for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:29:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7F4D940AE1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793438989;
 b=SwkKpCBVkds8KIvfiej9xiZ9r2mhLAbOyYBWPTFQ5P3yeDfYPaXNCxs4Vzrsc3KJVObd
 V+amD8oH3kSn+4yuroB7hgFTSYk4gFPGEw+00q0I7oyGGDxd3UFxF4NUlJvULJTRHrrkc
 tfneiAJ/10sBtZ5sGvRkKiPTvPUu3pfer408S29wGqL/Lwtsb6XPKe1nejAP4CAHPK3GE
 rlY6Oju3ngdvxHQYfN4eI3M3Gzc11EZnX9hpxZ1+AvFJYEdGsnxGb9287l+akvVnMRd6p
 lxg9qARZjBAech8AIUoqWnk2QlbvqSzLdok4HknrkBJuIWoKg2bL7jqqVBFrn+zb+ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793438989;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=5pMDcyzku+X7q737GHnrwaxUv/PxQGvEwpQ+fO2Jq2w=;
 b=htr0v/TIa58Pk1zIg0FR8Le507ZuIocIMMEC7lEA28SY/mBJq/tHeAdXnmpHXTD4yChH
 mG/JwZEV518DYoVFVmh51S9+/9vCjnz4j7gXYpyx2vYBCPwUbpDpha8XK2EeRSsIJ5yGZ
 x7F8RyApwHpae3MHiSceILii0h/wxZT/hgNDjBrOxTVJ+kbphAREC3O03TLbgISyTqbHW
 J+w7ulYaA09UhEiQaGeSxH3b23gll0vvigtb3xHez+NxdnV2tL0OGVik1yxfseaxDuw+b
 kJiiLKMpi4bknV5vKyc35EYxTMjTG2Cl29o0BdnqTfe4lrrQC38/ihPTQZHBS1rgvrA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HgxnlSrP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HgxnlSrP
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F4D940AE1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:48 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ac7c7b3a90so702085a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793438988; cv=none;
 d=google.com; s=arc-20260327;
 b=bCLl9p0tTeuHym33ubjm+3FfZPSsZd4LnmCRSJ2IkYpdp4JosR97vzvIHV3ujlHXWP
 HLlh9SfAHxG465fM+MlmIr6P3LRChYcsHQ7uRXB4yqaVTSnPzhsQFMawZ2QFvUIb7yb9
 KVieKH4cSbUqKI7NzxctT4DHYHngd/8k8VGQZRA8tZHXQ/WF8AG2dLRWUnmaLbOHZbS7
 NFtAgJUTSoCYoaRZqcHzFhRNtAY2aCisG3FQYuROkapoUG64AuUQpRH06nhs1h68gJV+
 cFdNwKAPzK/MKSsjAiaMdmXatzjlyChbaTGWli1LJMjNGiEe7NVgsKOZackYj4GVldmu
 JOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=5pMDcyzku+X7q737GHnrwaxUv/PxQGvEwpQ+fO2Jq2w=;
 fh=eSGTpZ/+rqpDSLRAETcqVHJrTBA7Fx3Zl7gWkQXUacs=;
 b=iDpp7M8ltIpUFh4ESxo3Szg58zO2XYbDtWr3PsGEenFizRfIHB16xjIo61mb2hg0an
 fEct4r/vIU63+VZR5ytrVrXLHu+zdZaaivy/2RKr3WvcOaqwREFb0hKUAJBNZ5Tw1cKj
 fMblcOUbnfLHSRIuAN5OHJKbQk2MDs1QipYw4V7+HSjb7Xs0fiCm2uXuf2rrCEQWZMty
 7Mh5QrYVY5Pt6OADTG55RBOk1xZf2Abq+91F0I2+KjOyW23uhMhOIMDJDSzZNuX+r90x
 2CsRp16mUZikvb2HHcwjgxlVivR3EVlxu28owCtc/vHJraP4xRxmrizbxyVhVTcx5p8n
 WN3w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793438988; x=1794043788;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5pMDcyzku+X7q737GHnrwaxUv/PxQGvEwpQ+fO2Jq2w=;
 b=HgxnlSrPq/BSFJOfe92Br/L0FH6G/byFCx9Ko2oalgCEoA+dtop2+0YOEJaXxxPPQR
 SaKEgPy5JpU1P/jDCMqluXgGI8BL/6QmAbegYcrdCFtYA8pyOPM10owjCu422uIozGQ+
 Kdie1PgXQixBuC3MPmq6JjVoLVnZHy/ThQjV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793438988; x=1794043788;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5pMDcyzku+X7q737GHnrwaxUv/PxQGvEwpQ+fO2Jq2w=;
 b=X5x6sDCip0mfmytRytM6RO4Rj+cOgcwb40Z3QyLH/861GRhHahAAH//nVVr96NXbCW
 W4BQAlE9vXUGI4LL2N1yu7o8jWRASMnKz33ylqu7yod/Nr6LNIEWZm4OjbIdo39cjV0J
 XnbOOn//FE7h6cjhTj+uxQ6Cjwgmtibqv9DcQLgeuFodNJr6ML/lGPOx8zfOad230ySf
 yh1lbXbYbzSBk0BUhsviIzcrzs0D4hTBiojehUvoJNdzWbVzhRSwfzUfOLLEZ5FZnxDj
 lSxvT2NMc01kYS6Vf3K2ZF2YbHwj/hcJoXkT1YjcZpz1+oNElVibxZJ3bR71OG3vi504
 RcWA==
X-Gm-Message-State: AFq9FYLerAl9304PlQYmsWmg8n4aks5zdAz5zOR0ZQO4smYZmhVWUx2O
 FbeJ3UKyWeXEZhCWv8cwpvpl6znUDmCq57fg6tOTZr/Ffy7SLEVStwprpkImDqYJjvQnne13UdW
 oH6ygMbHS4cfnv6p2IhBY65J5rQw5t8TpA3yW4+ZT
X-Gm-Gg: AYBFou3Q5ay7Mflv3egg053gNdvtM1q8KvqIyRdT5zwQhHPz6WslU1/WLn5mCMOL4uX
 bnpKjAXt0ZsGASxdHJDTDvb0h+8agy0v3vJTxOheJMIK+P9ibXP99B6VD8F8uLw01cYZNfXit+W
 aYR9OT/hUANncsM5Kg0UXQS5eTmsP4Ph4G/kSLsyrvjOohzFXXrGbYQ164UF8ULkbIDb65nKT43
 1wNrqk1cEwr1FwBYVAh6+KkGcZNNKTuyQHwQniyxJH+J//7FVq2MTtzbvPXx0hFdnEp+YWDEK6+
 wenorp4qZMYKpR6F/tGg4QOvrteBqRl+HUzoka4NcD3RXINNOgsTe2FlFHpwBI+5hva2ilHxBlM
 s7Lq/zklAT+3KuKyOn62UAWwg7rjwA6QhpAxIJx9YTc2XNS+rOfF5Ozi0oSzF1M2yZeJtqQg=
X-Received: by 2002:a17:90b:4c52:b0:3ab:1481:69e5 with SMTP id
 98e67ed59e1d1-3ae897ccbfdmr4326629a91.11.1793438988273; Sat, 31 Oct 2026
 02:29:48 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:29:42 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:01:53 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-3-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
 <20261020-b4-reset-edl-rebootmode-v2-3-f690da515804@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:29:42 -0700
X-Gm-Features: AclHuK9QZew3wmQX1gkxKIcdc8eK9i1v_lTk2I5lWIE0CT3tevD-LdmtW7-fzWw
Message-ID: <CAFLszThQZGBCDqmh5NqSPHJ-hoz3+kB3dN8JqEXH1vLnm2BZ=A@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] reboot-mode: add PSCI reboot-mode driver
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:46:19, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> reboot-mode: add PSCI reboot-mode driver
>
> Add a PSCI backend for the reboot-mode framework that triggers a
> SYSTEM_RESET2 vendor-specific reset described by a "mode-*" property under
> a "reboot-mode" subnode of the PSCI device tree node (for example
> "mode-edl = <0x80000000 0x00000001>" to enter Qualcomm EDL/download mode).
>
> All device tree parsing and name matching already live in the reboot-mode
> uclass; this driver only turns a decoded set of magic cells into a
> firmware call.
>
> U-Boot's psci_system_reset2() client takes only a 32-bit cookie and ORs in
> PSCI_RESET2_TYPE_VENDOR itself, so the trigger passes the last cell as the
> cookie and rejects a 3-cell mode whose cookie_hi is non-zero rather than
> silently truncating it.
>
> psci_bind() binds the driver to the "reboot-mode" subnode when
> CONFIG_REBOOT_MODE_PSCI is enabled, using device_bind_driver_to_node().
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
>  drivers/firmware/psci.c                | 16 +++++++++++
>  drivers/reboot-mode/Kconfig            | 11 ++++++++
>  drivers/reboot-mode/Makefile           |  1 +
>  drivers/reboot-mode/reboot-mode-psci.c | 51 ++++++++++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
