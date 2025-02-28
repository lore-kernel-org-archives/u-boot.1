Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35167C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 14:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADAFF809A5;
	Fri, 28 Feb 2025 15:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YnH61OBQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7292E80BA4; Fri, 28 Feb 2025 15:33:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58A92807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 15:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740753204; x=1741358004; i=xypron.glpk@gmx.de;
 bh=VgxDaH/jrUxmIKGN8k+R342bL23OhDTA8kd+Njt6gQU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YnH61OBQkY/EtjCNlavkOOlk0gOKhHfxkle9jdBkv6q1oMu4wYJa/kmtc5EgIWXu
 Upk54eGY3zBc2tjfX8NbcNdP7x31lZxGrZtJUD0WvZfgmThDSNjEMsbZhayuQK27X
 J0SvQXKojbz/VFH0kTKt7nLqcAVvL7nwkt4B3HNb0GrUSNg4KW0IDk/ZikOWCmET2
 9tCtj4oTPFI8IXojPmz6lJuV0qBTh+vrRNe30CiN1w2iiyMoUt5mG4mY3KDY2+G3l
 7NoV0M2C2F0NwH14vXzqt28hU9GHofif/6HGBiAl+sm+6yR9UXRGqKgCTw+URjtr1
 BjR8WkEIXsto28WyKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9T7-1twa022xcH-004q2y; Fri, 28
 Feb 2025 15:33:23 +0100
Message-ID: <26b269b3-9df5-4ae4-876d-ab41aec6baa4@gmx.de>
Date: Fri, 28 Feb 2025 15:33:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] xilinx: dfu: Fill directly update_info.dfu_string
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Udit Kumar <u-kumar1@ti.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
References: <20250226223547.393611-1-j-humphreys@ti.com>
 <20250226223547.393611-2-j-humphreys@ti.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250226223547.393611-2-j-humphreys@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X+2mWdxdF2wtW4x0jRFhS48ZXfBPygbD5D/43wDVjJloAgmCgbM
 DjxU8xA4p6yrsy7Np95l23AFDWO0wYFJaBsnSw+X6MG/sNxbFqYJ7dJZEq+EAOuZcrzP7my
 9IOaJQH2I4aEVdH08MUiVlyqtMeL2VXVw1h0ucNc2dzRYJs+FrnF939E+inK3xYmxiJPLrA
 W3kU0EWXaH/xooSmN2P1Q==
UI-OutboundReport: notjunk:1;M01:P0:HUL/VA8+YD0=;gRdXbw3fLyPWmX8pGvRpjNvaO5a
 hKQl+W/plu81WYUbs0qY+AWc1KROp16yeZrsVhN4pypwnneTlwyPYpvsK5iHr3LaZxe6H/KPC
 gzRFhe1quMEVN9cqmzGLcWSSFpwqphDx6iJYlE53s+A/S2uySLW4SsoDxpmLmg1ii8zHY/cMV
 gmNuIPVGduNW7R55U0ZBh5dl0liUn6ySgrAW7LLm3TRvG+kKGzIXh+SYz+c4UZ0YYoc4ztx98
 h4m+GMayEc+aLINRnVRt3ztNbuDvfQe4EnLzXb7GcQq7aI02H+OVvh3ZoCZiBsYKU3klXBRvv
 MVteOU7WfUXti+oywSScYvPu/lSNgejr+HMmxPVm3P1qFo6RzMDEH/SfLIQ51u1PoDeXM8yDY
 MMOXFtmOnS4FcRX9OHm5z0Ss+686Z6Aeimvkt64VoRRPdqjZu4iqZ/0NSSEYyeZSy7aI4lBsE
 4iUPwejxPy/wa4mt1cJqXBKdUspkATo8nz34IW4VNudQ1T2zUwr1mzCK2whMSFDPpUPvVDpjr
 m0II/nE3tdsitmEBgv1qOBP9pVjBMU7QePFuXpEG5sI58afrrL8KaLy5ZQCjnrpnmQ7oqxqOS
 JsFUV6Ao8NMs5dbxhR7px3krt7LNAs7Yc5o48oVtHOBSjoSFnf+YAAbVFZeNymdVL7clLAPxn
 2LQC1dZG8bhbaUzXwNutmdL59aM1PFt0mUb8J0lwQGVlKxaJKgrb1yyfPIEQGGPDXJDvQm8LB
 SVUcSX/b4RI4MeMX8sb14g4odplzJA9vDOHishk+YxfMbCrlh0gmIi/2UYfhoYd3PaqtBAY2P
 I2fKNtiFc8VnRACpkWmr1YxnAAGb6iHyUX3+fUbqNDjO17yH4bTGgsXpjkB3IYOyDXamR3gCu
 yA1W/iVSaWNi+zkv0JqRhe7Lj4tIvCrUYxXdM10LjD+kRe7+uwk3m6PK98+0hP4/0HUm1Eznb
 ma/IAUdWW8Ak1p4Q3S0/mW59kQK2jGwRbSRWKcO5XnEvBtkEf77cJTK0k2+1Zh7Lgag5W4WKR
 cfRA11izlGaq9lDxyybyTVSMcXqYl/P5bCK6w3KaETHuJiLywTmYXcORD2z9l1PI1VtfnAGpL
 Jwh+BB3hgwObioSL2klIPeR0fwhlVc8K1QmpcamaZTxzVOS+qNs+vNZT3WYlaMm6eskqZoVzo
 ysu/IYG7hXtFCdaZbKEWiOvP4TBRTJ8RfTkrFW7auWaOaXg7uFb7xvjW0KHTD9+CIMWPaIKo9
 0tmzQ6uLK7aWGzjLnINni31qoEuBbHAwDqUxJXYsORyBMThYEhZ24rPPzdnEP72mFffNgckFE
 eaiGRDRnYg7BQIMlDkIhuuWuyHhXFicHYq94I8Cu/i1B4I/81RQsksR3xH97A0676xDXMmcr6
 iQb7W1/5DppxWSrDcGzo6saBLDm2WPcNuykSQIMsWoWSrL+UwZJMPPMfQk
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

On 26.02.25 23:35, Jonathan Humphreys wrote:
> From: Michal Simek <michal.simek@amd.com>
>
> Directly fill update_info.dfu_string to prepare platforms to switch
> from using dfu_alt_info variable to dfu_string which contains descriptio=
n
> for capsule update when switch is done.

Other platforms only set the environment variable.

Do we have a problem that needs to be solved for all problems?
Or is anything special about the Xilinx platform?

If we have a general problem, solving it for Xilinx only would not be
the right approach.

Best regards

Heinrich

>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   board/xilinx/versal/board.c  | 3 +++
>   board/xilinx/zynq/board.c    | 3 +++
>   board/xilinx/zynqmp/zynqmp.c | 3 +++
>   3 files changed, 9 insertions(+)
>
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index b4483d00ad1..2c387630a61 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -8,6 +8,7 @@
>   #include <cpu_func.h>
>   #include <dfu.h>
>   #include <env.h>
> +#include <efi_loader.h>
>   #include <fdtdec.h>
>   #include <init.h>
>   #include <env_internal.h>
> @@ -438,5 +439,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>
>   	env_set("dfu_alt_info", buf);
>   	puts("DFU alt info setting: done\n");
> +	update_info.dfu_string =3D strdup(buf);
> +	debug("Capsule DFU: %s\n", update_info.dfu_string);
>   }
>   #endif
> diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
> index a852d5b8ed5..bd004b86a88 100644
> --- a/board/xilinx/zynq/board.c
> +++ b/board/xilinx/zynq/board.c
> @@ -7,6 +7,7 @@
>   #include <config.h>
>   #include <debug_uart.h>
>   #include <dfu.h>
> +#include <efi_loader.h>
>   #include <init.h>
>   #include <log.h>
>   #include <dm/uclass.h>
> @@ -199,5 +200,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>
>   	env_set("dfu_alt_info", buf);
>   	puts("DFU alt info setting: done\n");
> +	update_info.dfu_string =3D strdup(buf);
> +	debug("Capsule DFU: %s\n", update_info.dfu_string);
>   }
>   #endif
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 820fb252a3f..8060d54428d 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -11,6 +11,7 @@
>   #include <dfu.h>
>   #include <env.h>
>   #include <env_internal.h>
> +#include <efi_loader.h>
>   #include <init.h>
>   #include <log.h>
>   #include <net.h>
> @@ -734,6 +735,8 @@ void set_dfu_alt_info(char *interface, char *devstr)
>
>   	env_set("dfu_alt_info", buf);
>   	puts("DFU alt info setting: done\n");
> +	update_info.dfu_string =3D strdup(buf);
> +	debug("Capsule DFU: %s\n", update_info.dfu_string);
>   }
>   #endif
>

