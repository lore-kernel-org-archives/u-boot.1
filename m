Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D7A606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l17QZ1uJ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PsUH6GpQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFC5140B20;
	Sat, 31 Oct 2026 14:06:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FMDETcSoedR; Sat, 31 Oct 2026 14:06:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2901640B08
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455569;
	b=iqKnmO9nJUeRtGcHhnzVZG22ZXqhQWu8YZyabiaibHlWU5HDeAefbnJpf6MU6XR5JaU9
	 SFNOKMLe5IqduGBO0DZjJIv2oUnYpRGWxGGU31bNgyEcPnWKapFG+2zz4diTDF+QLrHvU
	 TZHq/53WKY3ucpVmW8Pm7iyDsvuvGfzKiVfVDSQiUomzSoJ1ENy1yMlFiu1Z7uwKxlHqw
	 lpO9OiAmeBFKTkG7bhI+KeQAV3+RZpLxf+l/N+gy91qDQjprY9Fqw2h6hbJcc1rJacDlr
	 JbUWZaVoOvnbQQr5IDbBrdHb/WYZnGORzSU1xC2JMTG4X8HpbrVZFWrfdxJy6quSKQA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LhYWvpyp/krP3+fKPR/ZlItKB64cPuPcwmwu94vzxCU=;
	b=TdZAe3vW/qdnsQzK+Dp/u09PLSWNtcXFrtMc5DEJBTZq8dFijJjGv9656uX0Y3GJLonY
	 gzopCIQt6LW83BEpVNf9PvXDLkrq/kfxHWXi/UiIbv/KGw8Ly69fqt8LARSP2kUKU9dQu
	 OV89q9bgRxgY+Ytg50h+wFqbecVepKtatFLPsUwYY+310C4IWDlN4n2NyX6QZR5nt/Rvj
	 QpBlwNl7SvwKadXaAxl4pC62SwOgvOlc+Mu0kLFy9EFR7xJlu0qy+aYagorZs1NPofF5z
	 BrKQ2HFHomsjcQ4gwdfa1GJpsosTwLznNTv2bfJR2YiShgZ624TwEhGlotiEqwNmyvQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455569;
	bh=LhYWvpyp/krP3+fKPR/ZlItKB64cPuPcwmwu94vzxCU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l17QZ1uJNxeOLx3gnXVUQExABkhVWPgYcmPzNHCAiTEpoQuwH8ZC1u9pYLf/xHEqq
	 VJv57PPja0oW/OqwT5UsaHR2YpEhaO5nqWK7tjtojOs//eEDH0qV6ETNYDF4MP4Tis
	 MqDOFkdOBlSmIWphK5ez8leql2LJ6x+RnVwqYDvB5K80SlQ7FuoiFaOgzsIYtaASni
	 L4cTzJup4uhOvOltm0qb/ngpHk40OdJ3VEc51+8bU1osQKA6Xnu8IahzcHlPMPfcTn
	 Eh0+DRIpHTk11gOVvbcufbeBR667zXFRHvtpqbXTX3zMOTzmsjZWDxamoHTJLlfMLm
	 +5aOLfXCTSUQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2901640B08;
	Sat, 31 Oct 2026 14:06:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A8E331DE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D31E810A8
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D4fnBeVvMYVN for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:06:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 573D181005
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455566;
 b=AI03FqSCOcLzx539WBqfdkq8zhfJQhRJrQFJyHRPmunXReAMBdt9011jHKEQuWr9IKO0
 56llKrmM8i6vDEtDR5BESYRLpq57M063IhRZdWM2wOFmG1KYpijGCFRDjNeeSp0HEv4KS
 9s3K+GC7WbPshfjTPv1ZYNUxFjyA1pBA9D9j7eC+Y4gMSnQ5NtSSCHm90jn3KnjFJKrnH
 pMYDk2belabX2PCKvHA0jmIc+OgJsTmCmVWkmgjKmpN+5ZSTGMmPbvrCxmy5+ehYxQQns
 1GTbnngADMerrHjkbGHaWr6PBmdSZ2/cw/Bb2CH1sGffIKMEabTFD26I89VOWif2w8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455566;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=LhYWvpyp/krP3+fKPR/ZlItKB64cPuPcwmwu94vzxCU=;
 b=UY7s2gAtIpHvmtGHzBenrVRrtAqE6yrn4/jYE2Rz71raZ+JvnqsHz7qVp05Zdwq0kALc
 2GvdI4pKOy/lUVXbqwH+H26fnVLoEuglgsMDDOj6SvGeYgcebrfc3taYNWzerX6lFJUOZ
 eb+V2HkDQb130cQz3VSi99bJe2/+PYsrQt4EyJeeBv/PgE2e6NYHeK+htMTfuz+Czj5aC
 sQDvosXaXugHuJUlSgUwNh4BUpkOpvAL7uULogpNlKCpzsEVzp4BuPFNIPg7H80188D/K
 eaPhu//g98NRRJqFbWOe074waYuBPHNCKxmjWFoC7AusDJl74OXlVgiAn39QI90NoQg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PsUH6GpQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=PsUH6GpQ
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 573D181005
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:05 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c49b431f022so225667766b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455564; cv=none;
 d=google.com; s=arc-20260327;
 b=kNNLSF2RFn1d6OpwmiDZY2T8g58slCJw4kBe5E1H3nCIAKVvd2l9mg+7BRvH7BehcQ
 hTHIFIu8quQGvB4xReWfebSyhyRVe9sq7TH23k6IcCwoBaPL5/c+h529B5JzBkuuUQnO
 V/lVWY2izCE9X4Px35C2WTOoCrvDof/I1QNg3EjlNsVw9iu/DHxX+fyDGxySLWIPD8Q4
 rLJjizQhY9zlMRl1U+SodTVwBjSfhT0tag9no53c6mA4uu9ejPv+KjQdnkfIq9W2chum
 GryNd7ORowHZ9AjMf/wXpyU/W/stsh22y+1Oa8wL01xld9aluOUmnsmVHziSv6GPxiwk
 qUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=LhYWvpyp/krP3+fKPR/ZlItKB64cPuPcwmwu94vzxCU=;
 fh=ATCEYuWoi4V+EneYfkEkWevuHbMqtvu7FmKAf8iNcR0=;
 b=LBZNBs+Y5rkMRPYxyLv9U+YdfXKhu+E9E+SodfoHdNJkleQhS/2oEW7st34O/XgR0K
 MRIHYxHUWKxul0XEuMrrGx7qvFblxwj+bovE3Wd+hwNPxOpR4jcSCm7LX62w+Smaqps5
 qll4f/A7BiLu8i6Kpf61QNn9kiv+2vF5hRKrQuz2JofROTXePzpxfILxYfnjhRUDB679
 UL5SG65nyWy2tNDVMUtc8wG9ijucHdoxVXMl8/+IxgKRH33l7J/MDkmWovrfLxpMghCN
 2mWdKOwr7OhT1Z41i8sRy+RvvxQewfZrgyW8+bWjNni/K02BzuLpU0jBBap2G0WOG3td
 OfkA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455564; x=1794060364;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LhYWvpyp/krP3+fKPR/ZlItKB64cPuPcwmwu94vzxCU=;
 b=PsUH6GpQ8y97cy9YIg6LYBwAQUN3r946m2mWrlHGRhhhBqi8/jlz7LA7TUnhvtep1u
 sU3VX3Ao00CpSUsa0NRDouwlY2NTZ0tccWNZn8ZrbLkorUFTy4JZbXr2oP0u6LtfKUfP
 J8nDzm10o6mpzirvm03MsPnoLQsXCJGWXn78I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455564; x=1794060364;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LhYWvpyp/krP3+fKPR/ZlItKB64cPuPcwmwu94vzxCU=;
 b=Q7/yXYyj9S35zxbo8feUUICdbQf3dPt3a0N3ESPp3u1YscdJvhR3hLT9TVjK3P0UYn
 6RVztWVHvRI/Cf2vP+Ovt9RnnPWes1UPvU4vAWnXoHqpKMVc5htoSUe7RM2hJj5EA1AJ
 vkTIlzP7jPE5K7qnPEFgYsmnzwuO6q0P1Yx+TvlDPOTrvpHt4HRB8ALwMbM++Xe6BQnI
 QLH8wzmdZXCtywcvfvhHmgmm3B0CNxydNQ4Xv1HH1SRRi4l4ruLf4jMHW6REoJxAh+ua
 PmV2hMcEAiMT9H4R6gXqzIVV7gWFsyX4s9WteWka0T2TVnKEmTtGAsW4EXYiNcrD7zG8
 HGbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByOnj4gzoNw3zcCQt9LTg2nM6YaAtoCH7vI4AMxyxGH83AnK+NQBNrtP6B3mzlql0+OGYc6bMs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLaRMJnAbGsJtqtG+j8dczj6GSqT9ZrPIFj7pKRqbKImEUVa3Ba
 8yvFAuNLyqLzc+c3iLmn3h+QoL5cr1OBy4eaft7G9l3rbSpe6CQyCxV9Tv9CqwBEEYUDBq/Ps7R
 vzKr1FBJEJxn5ig/Bwc3PxRvnDQi+X0DTk5ZGIGZp
X-Gm-Gg: AYBFou0GZriDpApjBpsXhcUMyDw+OIS+L+TDS3BUbV3vsQP8mdQgKvKAkbnhsUVKFGB
 0ON9x2bKbfpi3fzBWR3qRZ/cowpHqRZyeFgx6+xaqzrwdS41Sg8lxq1lNIrZeXslsLE5XEPf8Ht
 oc+TkpP9s9aUnP9BI0K11r9/6bcRg4XBMWLWoLxyZWE4xiwSsN1sdPoN+O9nLL5Q63grYJWErB/
 2BQ+8ee/JVZGbMEtY4ApgquuLCmueV6PjRQXKgtrjBdwx50glD/+T9jB4iYJII4S/sfi8a9c8hE
 Obut6pv0OCUOTa3DAyBx52ZY4Th4PVTMIlpux/8ZGJCw7q4YUxLuWJSC/brmiZ8bamsRZ++E3ye
 Pl/ISNPl01WFvSAoAhUIMIan9llA9C4+AGjLCn+tYYdROcGKcNEABfaG25VsLnZHDzKZecnM=
X-Received: by 2002:a17:907:940a:b0:c40:f9ea:7387 with SMTP id
 a640c23a62f3a-c4ca793c608mr445545666b.6.1793455563965; Sat, 31 Oct 2026
 07:06:03 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:06:02 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:14:34 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-main-v1-5-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-5-b5a878627107@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:06:02 -0700
X-Gm-Features: AclHuK96vb2k_B4Bvs740QkDpEITdiG8EcE8m782c_dcsIkr7wb7kE2ZGp1EX5s
Message-ID: <CAFLszTh=6zB7crJ9FhyYQGE8DMGXmCUw7pgT0hvgBi7YDTvsqA@mail.gmail.com>
Subject: Re: [PATCH 05/10] test: boot: Restore the bootdev order if the RAUC
 test fails
To: frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> test: boot: Restore the bootdev order if the RAUC test fails
>
> bootflow_rauc() points std->bootdev_order at a static array and only
> restores the original order at its end. If an assertion fails, the
> test returns early with the static array still in place, and removing
> bootstd then hands it to free(). This trips the dlmalloc checks and
> aborts sandbox, so the failure of the flat-tree run is never reported
> and no further test runs.
>
> Move the setup into bootflow_rauc_run(), which restores the order
> after running the checks, whether they pass or not.
>
> Fixes: 36add050eea4 ("test: boot: Add test for bootmeth_rauc")
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  test/boot/bootflow.c | 48 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
