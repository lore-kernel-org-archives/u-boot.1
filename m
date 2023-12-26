Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60038C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E33B87899;
	Tue, 26 Dec 2023 16:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aJLTLybX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0345B878EE; Tue, 26 Dec 2023 16:10:13 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0E0A8788C
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bb631656e5so543163b6e.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703603409; x=1704208209; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQgZSbiIG7MZK3LjQUqVFTI3hj/zF86IB1iz/FE4/Xw=;
 b=aJLTLybX7QUx/T3JkgGplnwaUE0hdOJ7imrkD9WKW8PTuYv1vksU4oEeAjwKGhhR1+
 I3kqMtc/gyZNOdok4ppZcfk8kmuNcZVOzZR7MvR1D4qnTO/YsjQobtrwYFaPwvxaH0+J
 vFlH98Xs8rtVstHcSkT7NENrwSQmCfjTQgs+AZ5zUdF4QRUeUMh+mDpEFK8XSgWAsOA6
 lRlkLIUhDBHLDxgEu6Asps6E1mMBxUzxa0VKEBM/dnODMZ1tbrAw9ckqhvm5Q5NvOhLh
 lbemQxBcxEo3gfmZahR88yTvhih7jhgohv9FlOCQWXDp/vC74CQ6KD+EaB4W2hAUS+mN
 /I5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703603409; x=1704208209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQgZSbiIG7MZK3LjQUqVFTI3hj/zF86IB1iz/FE4/Xw=;
 b=hLsaMR6n9b7ViCo0z6r+vB5QD1y7M2lVWvBEVmrQjW4Kg0TGTuE/oZ1DQUzerLKMOt
 gMN8bmKpRpHOIWWlM9At1WZcabWOnHjzKIumRgEeDHqRJWOMDnT/1STnY9HGYqcbqXq/
 Lm+jpj0VPa63OgMEUJqsA5KpSd9kHlLjH5OcER/KBCMbh7iJV2fbkzxJvcQdU9SPYEO9
 Y7vONrDaccXk04y4D1+uVW0k3ML/f787awpECVAOKbGwJsVLteVqmJ8YRnsFBhQ4fNiR
 f7GiMdb8Flb/FQom/81D8ZWi3hSqHhLKUfzACf5Gjb6mj6fih0oowryMC4O58svzLBa7
 uQEw==
X-Gm-Message-State: AOJu0YzUCpOktfXm6U9EzEGJjhR2xpoPjd19Vv3ut1ms1gyc58anYNjj
 RqLrdOQJFPC3jT0ZM7lQTe71E7qv4Q+aIBmqNZOT2r5DbwQ=
X-Google-Smtp-Source: AGHT+IF5NqHUabe97l0hjZjgYK31ndOY9kDNg+FwqZDAwrh73exdPBw9gA69+HeUxNHFU2VNXj8anoOZqXpoZp48kKo=
X-Received: by 2002:a17:902:e993:b0:1d3:7788:1c40 with SMTP id
 f19-20020a170902e99300b001d377881c40mr14703688plb.0.1703588676358; Tue, 26
 Dec 2023 03:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20231226093615.530089-1-venkatesh.abbarapu@amd.com>
 <20231226093615.530089-8-venkatesh.abbarapu@amd.com>
In-Reply-To: <20231226093615.530089-8-venkatesh.abbarapu@amd.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Dec 2023 08:04:24 -0300
Message-ID: <CAOMZO5BjDqwJ_qoToGZ168UxwqYDaPwFSWHX6Pzw1LVTaw2YJQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] config: xea: Enable the SPL_FIT config option
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, jagan@amarulasolutions.com, 
 vigneshr@ti.com, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Please run /scripts/get_maintainer.pl and add the board maintainer on Cc.

I have added Lukasz.

On Tue, Dec 26, 2023 at 6:43=E2=80=AFAM Venkatesh Yadav Abbarapu
<venkatesh.abbarapu@amd.com> wrote:
>
> Enable the config SPL_FIT.

Please improve the commit log by explaining why SPL_FIT is being enabled.
