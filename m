Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9124D1BDF2
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 21:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF1F88D29;
	Mon,  4 Nov 2024 22:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fZsvb4BM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D151288D4A; Mon,  4 Nov 2024 22:22:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 990E188CF1
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 22:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730755336; x=1731360136; i=xypron.glpk@gmx.de;
 bh=3WX5EJ9lBDVWEqG9BA3hMnUlkxcTtv/kG6Ovw5EmpAI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fZsvb4BMOYDAUCtcltznOBxejSc8I0mj6JofP/acMG/2WekDUWxN8sG9RvsMojWS
 MV75JFXQogC/kN5GxjXRbBqqQni5tft2835/TkTPPfCWdIBQVNRuiSuhSHpgw4rJR
 s3OmGEt2Cxe2xxjyafEvltlYNrFgHMEfoRF9bDEw2IZO8QXKdcE5Wa1c1iUDp9STm
 jHzPT126BeuIVMRDlKYXiOLjU7GMK0eYFWuU2YtDnh7iVGnJjM280kycoaEGnMQct
 3K94glTVG1P+qFYvcUt76ZMfoingwiGqrYiszieUcycobFL8a8L3Y/5pvNfoL4ldX
 Uoccj72eJIxnoWO9Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.108.63]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUosT-1tGd8A43pR-00M30S; Mon, 04
 Nov 2024 22:22:16 +0100
Message-ID: <39dd14ea-6c35-48c1-85b8-80d7c23de8a7@gmx.de>
Date: Mon, 4 Nov 2024 22:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] docker: Drop tracing for arm64
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-7-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241104133954.840994-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XHiaVJmEDNXng7S5+VKQxUvBcYKL7tre6K23qEQ61ylLwKz/2XF
 COl7kDELAj/yOaffCQfQ0cVa2FHO9nt49Clg2ShV+aQQkZBQyOP2TsMlmrjbwAEnfBbfzC7
 Y5Pj9xTSrRkF0aVsYxBDkakywo/scJJX5Ma/nEhiUAZvjN2Af9wrx47dkykn7dcX189CkQW
 vtS9L0BlO/1i890VpOKLw==
UI-OutboundReport: notjunk:1;M01:P0:UyQlH2awZgE=;RnIgBGvIMQJOF5QdvcJKRDadAFk
 kHgeDNq+HUZmnxhp/4M/nIsRqOOGMsvxlGvM1iESK0J4pO75Gw9kd05R+uMGvl8ONt0GQ1Zg5
 HO0RrmQUCn7+zedKMLwzii4sYe34xIYoy9FqyEd2OISlpzImnkpPCuQGSG1Mx5PdBcXXVljhz
 LABmBN/+dIbbp6IAtQXrkGjNJulJ7Ov4R9l+R/iqbbW6W3ZU/E7Z+oAU/sCA3CG9OhntUmi5B
 SaUf+FyCKTuaJScpAf5f3VnOb+X99zDcpsXBhn+15G+W1IX7mR0xSFb9Wxr6zQ+WJM5z4XsbD
 VEnjXRqwiLn7d5hRYuegsD/8nYZxrcB2QOqiE2iKbgeFO2l0ZfD3639CP9Nz2WrslY2FHsJWT
 ZCLrbMMoK7YDgWseyI8P+oY7SP6nFl9Cg/VcvwgmFdU5YkJAlX82Tn/5CAXCsH8h/AzwNSw9h
 B/NqiDaGqeiAW7CRANdDBlz6WuyESidPu9Bcr2ibO+FihpGYUppKXeuBd/tKR+wpTUvxeiqzJ
 o4L23v6/Yf9sNFLbZ6anMzl5qOTdJ/1U8UVMK3OClEpwi389mNawE8tPD4cDzGKYvVLkoTHur
 Efr1327C5kMM88FnjI6vZvnxGk6QZK7337qVP/ErfKxyaasFLTomuqzBhAIwIa6h6J9X5szIh
 zf8GfLQsp7yIBIGYNowWIomUihq6hluh6oDiaSFkXOG5ghcZKTOCbP8elTlwtGtawX39GoZME
 jFpAUjMQwZxQRNGh3q7gb672fawMAEIIdpgnmLeTNQ47XJJxRz6xYugNdvYlPKIwIE6O38Fhf
 ssknJRnx1hMj8m3nI/zPuqRQ==
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

On 11/4/24 14:39, Simon Glass wrote:
> This doesn't build on arm64 at present, so drop it for now. This can be
> revisited if we wish to support arm64 for the sandbox trace-test.

I had no problems building the trace libraries on Ubuntu 24.04 arm64.
So the problem you experienced should be easily fixable.

Best regards

Heinrich

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   tools/docker/Dockerfile | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 60106a82801..73fdd1a4302 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -240,7 +240,8 @@ RUN git clone https://github.com/stefanberger/swtpm =
/tmp/swtpm && \
>   	rm -rf /tmp/swtpm
>
>   # Build trace-cmd
> -RUN mkdir /tmp/trace && \
> +RUN if [ "$TARGETPLATFORM" =3D "linux/amd64" ]; then  \
> +    mkdir /tmp/trace && \
>       git clone https://git.kernel.org/pub/scm/libs/libtrace/libtraceeve=
nt.git /tmp/trace/libtraceevent && \
>       cd /tmp/trace/libtraceevent && \
>       make -j$(nproc) && \
> @@ -253,7 +254,8 @@ RUN mkdir /tmp/trace && \
>       cd /tmp/trace/trace-cmd && \
>       make -j$(nproc) && \
>       sudo make install && \
> -    rm -rf /tmp/trace
> +    rm -rf /tmp/trace; \
> +    fi
>
>   # Build coreboot
>   RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | ta=
r -C /tmp -xJ && \

