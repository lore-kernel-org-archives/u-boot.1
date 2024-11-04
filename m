Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4999ED1BDF2
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 21:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD1C88D29;
	Mon,  4 Nov 2024 22:25:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ntLIDQZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA00988D29; Mon,  4 Nov 2024 22:25:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BDD288F08
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 22:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730755497; x=1731360297; i=xypron.glpk@gmx.de;
 bh=Bxl9KvBGK3zZNbUIQ5p96D8/CXibAEIs732Scn3FciQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ntLIDQZ1GZuHmqrcA8TVWtYlAf3eF0bDtDzgOpIcPbg9osT+kHL26pekCxhhc3dt
 HI5fGCSQohZ69OR/TXrl6ioYYm+1SMmmHLDkFS3n/kqz9Kbp+BF1zHo11+GVLCBCR
 6emp5ZKyrH/SnBobc4NwWiifYqhjBbWF+pxj3idwVoVk3viJ83jvemqGgHkUcVYfU
 Xp0WXheKb3wR8zkCobjSEn44HHmnII4u7GIiKMjZh1DDAPMdVVKW96pAwoUDlmrvN
 DAhTUG1JNXueSmDbijej5clF5S+ca1lKHo5hsH9LOaI/NrIUy3gEdwnpaLACygaM5
 EDXcPmmT+eRb0dFGgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.108.63]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHG8m-1t3caG3Oj2-005EO0; Mon, 04
 Nov 2024 22:24:56 +0100
Message-ID: <c2cd790d-9e77-4c84-bf08-dfaae916ab13@gmx.de>
Date: Mon, 4 Nov 2024 22:24:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] docker: Fix LegacyKeyValueFormat warning with
 PYTHONPATH
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-9-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241104133954.840994-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jtLw/Idmy+z0JLolKuVtYVDorqff6amjQnHO9kJeGI4kKW7OAPH
 RVza4DnxerWRl9ynzXlLcy3gXS0wjF0dqmZWxl72n6RKO/+9FnCDvnCk3mcBMRj7SMwAWuC
 hw6bsXVt3zU2VUFADgDc/a84hJd1kp5GLmbZVYxIlM7nurIRcJ6vRKhJrUtI36HeTCjxKpN
 2w1DQrUCP2D9O30+eA8qg==
UI-OutboundReport: notjunk:1;M01:P0:QEMYOE2eWNs=;raOSBlhrjwdqfBq+Zj9WjzMlYiU
 Jkpd+sHL8M2N9KW4S3CJbJStI25/vfIVI7BtYFF9CJ6egvx6eOK6hkm+cP1PMD3k7LvebyHaH
 KifoD5tr057aHx5mEvhuGEeEEuyBftfb777sL5ibGJXDzGjtIIPfboM8vv/H5w4Xb86jvIDtP
 q1FgF72Oq3uuE795iztPvXNw1fR3FNL6ztmBfIUu3CP5iD2P85TrY1NA6tCxyl7ixbSeyJyAu
 Mn3ZeOZLoT8YKz2iL9EKS4o2AQh73YCKdCD6G9JGuIhPimLBDx4TGXvW7FY4JK5yoCDxMQKXw
 SiwKunT99++e9gZnjFEvjW45QTnEqQ/vxoed/Ibw666DFlbGC7zEmjBXTXdJ9B7ya80EAwyJb
 b2/+hGHSQk8v2Rhxd6TC2fowg3B7VK+04/O8x1LpKPfsek7NIc3YSsj8uXotvJGlNut/NggOM
 mCizjCIzq27X9OJt6iTcDys8k70dGtsbUVRLbmje8kzR5IyWWEPLO7q820xVTskIZnQBEcSOG
 00Ge6hiaoP2FLvDZjvctIXVUzypgJEPJ74MBIErvCX6UmE1TcJO1ZJHDp1/Qn3wGEGFMu+Skm
 gmk+bHxP2lMzLiYEs72X7CogLBgE4zgdc5Aj8k3EyvI9AgunqmDu7uEZQGqCTGOX7pz1u53iq
 0KvtYoe8JCYDevybNV6m30hXStIIl8vWqupbbbK8Jet7dI9W/d9okttKfx4SLLHUvjPxC1Dvx
 fb1vtJw70Z6mAuH7RKZvciJos0SSOB6YrlRcCJtmPcw9mtLEqLHeHHnVp8xiquNyDR0O4q/84
 qK4ZRQMCw766SyDLzl+eNVVA==
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
> Fix a warning due to the syntax used for PYTHONPATH:
>
>     LegacyKeyValueFormat: "ENV key=3Dvalue" should be used instead of
>        legacy "ENV key value" format (line 304)
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
>   tools/docker/Dockerfile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index ae3d4685869..c42e0890897 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -301,4 +301,4 @@ RUN /bin/echo -e "\nx86 =3D i386" >> ~/.buildman;
>
>   # Add mkbootimg tool
>   RUN git clone https://android.googlesource.com/platform/system/tools/m=
kbootimg /home/uboot/mkbootimg
> -ENV PYTHONPATH "${PYTHONPATH}:/home/uboot/mkbootimg"
> +ENV PYTHONPATH=3D"${PYTHONPATH}:/home/uboot/mkbootimg"

