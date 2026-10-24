Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F3606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1ATHMK1m;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GMkpBAML
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B97D81767;
	Sat, 24 Oct 2026 13:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yx_9QXGDahkI; Sat, 24 Oct 2026 13:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 07482816FF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847012;
	b=Kjo3oSh60ASv2+REXBZi4BndV7UuZ8wPGfW56H/CutAl8SxYZx3nW/yHW57Qxjbiep8h
	 6ihNYr03E3zbtGa3ukvcBgzMIktdQMZfHWYs3WSI4+hBu0b4X3woQSdzeXhvcgz1bYpas
	 c7zwivd3jLFZQKA9RpAT1tcZVt87NEidOG0EOaVMAEFuVkQwKOAUpjF3Ydt1PQdJ21Har
	 uJINXWe+hbQBhAwYlS2HdOmjz8rFMWb0Ar7wRM896XoxQIV84cW5Do5P2LcbHjh3GvXt1
	 CH+B2ureodX0qvHoT91X/jL3USxwl44Db4n1jG3Cs+XcH1xSpXZ54CAscPfI///dGmw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=x7xtuoUdE41/4MLFpmq2aQtFp+0VSKxwjrzla0LK4mw=;
	b=aO8IJshD5IKQC91HlmHz+pnOtjdCYsH8obIPnDJjjmu/BqlxR/YKT/Sg4SzdT8IZfvqL
	 FFYMuD4W7y75YpFw85nHTJjv+lJntfbnchDVL1opzDYm7KSq8/FBvtu/Q3Jwe20xxeOq+
	 E43Q/1zQE2yTsy3scRearI4jIwCiskOJpavgGBOWpunxuITY0jR03DBfcGZwGLrDPNRdG
	 3/tsFGYxGmy2ZN0SikF/j4DPFQIPbwg5+M3cvf+u62YHtjDMQzjW6nzdBdXTL8gEGVTqE
	 jMcHf4ls9FvIMdSY1yvUc3bRs3PgLrPVcIRQ/DGeHEmZCG0Ci0CgM/d12z8gwTNIkyw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847012;
	bh=x7xtuoUdE41/4MLFpmq2aQtFp+0VSKxwjrzla0LK4mw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1ATHMK1mxD2zr4cdaT77TB1zGvug7nB86wwUl8HcC5c4+LQ8Y8UV6KPl6fXqHgHCz
	 v/BDpxahwiBh75umo6pfW/9ZMt28Yqx5gzGOfNburtPii/ffZkdddl+vY+uaM14LN7
	 d8NB/FC40NdyZ/FtdZGiaXcKJl4wkqXb+jczS1uewP+x1dKAIqksfZNft5tz36krJo
	 V49SONmD8Ani9a7JM1AKecRSfgcbztPNqr3P+KTWRHWBwuGPqiEYyrOJodVPJkwofW
	 rHH2nRehHbuZxM2todxtqVOLX7Ddk4y3ICyz0xFi3mYaU9HW+6oN4PBrXSwkyl9OHW
	 sRyMYXVDAgzkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07482816FF;
	Sat, 24 Oct 2026 13:03:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D0B60765
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C304A40AB9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:59:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0LCpFUe0O_OV for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:59:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D83AA40AB1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825198;
 b=pOnbqrtw9ukXsEaHLw+NeuowRbHGl5G+7Wkyb9XkWVjn586pAnc5VoYxIEzHSJ5VoPNS
 mEVoX5G25gQLyIiHx78DTZWZ4aykeYuwsd1wy8Kj6puEvpx2ULNmyd4QRR+xyKKkgB9SK
 gddt6a8I4KtK0U5hYjHd8pGqSEG4Xa8dqHwGJDRZLSKr8qfY/SdGVLeQDCpuY60alzxu1
 xU0/Mbv8MbO+fi7FuTnQHyuOzQvVoy+9dHTeqO+f6YsSAIIigNnHtNNBbbnJQMI8PRBPl
 zU+qgTUzJlQkyqWNA/1J6CIsT0Njk2y5dHXfmBt02wsowYMoZu+fYqRZpw9It2NTlBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825198;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=x7xtuoUdE41/4MLFpmq2aQtFp+0VSKxwjrzla0LK4mw=;
 b=XhB4CPv+TxfYXNhYcuw9vhihi6By0F6F3Sr9WibJnlPCt6RrWnivuQTG2NyW8CrhqnHI
 MC4cnLiefW1Z63C603Oj0iButF6DYYa+MYyekfmYPFc9BEfQN9+kfSvyeZWL/fxxIqnEM
 KA+91c2m4CO0nJBk+EjkJUUt6NL2euXJ8jMWXlM9ZAK9j2ZganA3gz3kJcnqdgLwqhDoq
 njVI6WIt8ROETq4l/Uv1c/F4PYiGY9p+hxR4FCjZC3XD5eAnm1wgWESQjbiMlf2zLnz16
 HiDo8sVdNttL1A1fqkuf7RtbrLXbsbnlTzDR3EzkYkSAUDkkdtb1gkKON+9prvu+D8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GMkpBAML; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GMkpBAML
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D83AA40AB1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:59:57 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ac91ac8924so854386a91.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825197; cv=none;
 d=google.com; s=arc-20260327;
 b=DwT2T1qrfIlFO1MwMDT4nXsVZ2wFut+Ncp4//ru4K1ypGixQBaOHrNz4zd2y6AYaaB
 vgiOh4hVP08Y0LQGkLWE5IiaVdXWnD0CSETgwCW865K9GBnM7LnKRkVdfa7hMgptC5lX
 X7LOFXH0n58bd6022//1L9JRURX3Uhf7ySS+dweH6wsypijAoofIaMPZnmc89CtgyK+v
 7G7UGJJ5Y02X9dM9RpeCNZsVurHiuv+QY9Iy3of8L2QEnrTLEJhSJFGIyf23GzgGdc+a
 Y7GKaGZebXj393E+ubJeYvfiGCQkhzjASkOWQ36dwuNlixK6Z/7oRvAkNOdqHtMMx1rV
 tnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=x7xtuoUdE41/4MLFpmq2aQtFp+0VSKxwjrzla0LK4mw=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=VNWSc2KP80TC6m1YxFC/PzmiCfbUTxigvjsrV2ADDRC8lPBvC07fc/0eS/OkrLhJzT
 DrD22GwR7hIUxVOGJA0zOliDgETNBtEKNdyB77DzN7ydoLDIqeGe6l1sYsV0qVXH0pOZ
 Cl5Aten0Tn02DBX6Y9EiB428IG6ML6bPiYFJ7QrDNhDn5BMRKOnN50GVhLLpumrvdufk
 0C6AQcnfI0N4nlzzlaguR38jDZKQ1Xf/qLnMb6/kix6wz7GUzwfMgi6xiCgq1C0ooo5G
 GUlXgjhNmI/fck82rZNj55ReCWqUjvO7jycxtr9tP+q7ixfYdJBdZLErdGUQ1fs9qt5/
 KLlA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825197; x=1793429997;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x7xtuoUdE41/4MLFpmq2aQtFp+0VSKxwjrzla0LK4mw=;
 b=GMkpBAML5C9MnyNNxG1zrv0Td5L70wTB1VVqIsvBWY/MXpoxIKNKhRUttAlqyWNA6B
 +QvW3bRiGZ3phdoEw6iJO8pUeErAxenRuB8IHeKwRx7McdpXdG6LztMbU07H2Q5d6wxQ
 8cXGb+1kZRaGjMiMGwgpklg0uyKYhaBV7S1wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825197; x=1793429997;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x7xtuoUdE41/4MLFpmq2aQtFp+0VSKxwjrzla0LK4mw=;
 b=homvZw6czCdODlP9BWvJX/r847rxCXyaX3I3KGdJ4xT4MdTTimLEbW56A8IKXp0COi
 5RMq/DVaLanDWYYRL82D94Kiiqt0qEvAzOjPxa24LoNn/MGVjEpqkEvABUDWUdTCuIgl
 /UFLSJz5/S5sNsaFh4tJhuM2zJNuK2mMgQua3uggTbKUKp1CH2MggnnOy0P4SfgNmTdW
 lrstEWsrhWMvMHkvaseGe/PQG2vtGIVxU4vo1oT07bLEBGl/QyEo0B0sJYi/uPVwa3EK
 Tac/O6vf3oJEXWS4p67OgcJbxhSXiPxqBE1jCz+O85kkfL0isXB8YpFZ94pUEx5hqDIB
 6Ozg==
X-Gm-Message-State: AFq9FYKB9KZgP/vYyc9hOahqg63NVSDF6i3pFRXMTiWYWajM9HPxGyOE
 HVKGIRyb5Jua8EvNaH4ntjen3PM21N5IGKUUCv6uBKLBqsWDuLin9Kgrc6fsrsIpaJs24vbRfxG
 RbS80YA0Vqc1z8FuKUWUdH7AdNPkx061bXD6kwZRZ
X-Gm-Gg: AYBFou1qXXogFN6PPhjpz2bGUg14S3N4dYCTAzET5e4fVdGrwBJAfv7AZcNZgNFNSVa
 nPhh6l2nYd1ginGfsB91O45vmJBC/SAdEdFvDKzpfe3dPkNpVIB8dkWQKka0l7p5K9GPjyHTX7p
 zKwYGNjntrOVY2niOayhJSA7fGxyOLEgB3unlQW1LeaVYVxp4G0WSqGcWAm7RYdVhayz/RGJPJN
 S1flbB99wvBeZhh+rR6SBrdp5H5KS1dUJg2prBSZleLN9jivKkIP6tV0wXYvD/I28R0I5WBmvDm
 Hv9DCVbsXhirmcYyFCeMzCgUJzLpKc7vTQxjKdEYwtfSuEtWUUdw6ardshbK0TrXWCMOhrdaa97
 rZGFQ1i65Stq/aX6DKzUyy+q26KSnoUSXtKcv9o6czanPR0Wy7AdIKTUN
X-Received: by 2002:a17:90b:58ef:b0:3ad:93b4:718f with SMTP id
 98e67ed59e1d1-3adeafcf07dmr1134825a91.65.1792825197076; Fri, 23 Oct 2026
 23:59:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:59:52 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 05:16:23 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-2-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-2-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:59:52 -0700
X-Gm-Features: AclHuK91J4ay9RaNMPpeoh2DZnZsprX2xLYqd3WJm75NgYElcl4EIDUfvX8PBVk
Message-ID: <CAFLszTjo_bKjWexM7rCX=Hafgp_WoA0eykRYBPYrj+QEy-jczw@mail.gmail.com>
Subject: Re: [PATCH v3 02/23] spl: fit: Stop reading the image type
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> spl: fit: Stop reading the image type
>
> load_simple_fit() reads an image's type with SPL_FPGA, or with
> SPL_OS_BOOT and a decompressor, only to print it in a debug message: the
> FPGA path checks the type string itself, and the decompression message
> no longer names the image in SPL. Yet it links uimage_type[] for it,
> around 0.6KB on arm32 and 1.2KB on arm64.
>
> Drop it.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
>  common/spl/spl_fit.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
