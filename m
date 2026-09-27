Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5687AC9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 16:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F369E40467;
	Sun, 27 Sep 2026 16:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nXUSoYVaem2H; Sun, 27 Sep 2026 16:46:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4D12640695
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527577;
	b=UW7ZVzk+mRhGyBXMpSdclJycd+xyMg6W0hzF0uGI5mhW9gR8jowNYO+sQ8Bp+Jq4jEl1
	 WRrkKJ6u7F0gMiinMUf2cZL9UxOct6FJVYewfyMZG2XqRZx7iSofP80MOxMwANKamve8g
	 8H4RQ6knTnwyUok0Yfm956Buf0iZlvUhqeERn10ll8NsLXlPzyB8fDoEVGWyYPgUrwqvB
	 2tA+9lCmxUQbS9/lwbGcUTpn4RtHIfTPsA2PFwPs4KgAbB9UVMNlLUODll1w30KnlevmO
	 Jhnh8xf2jQi8ZQdzsJ0hRP2WWBwQIiKX913P5T6TWtQb22aebycO8tigOpYGri6j1wQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790527577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Id3KAcgrwFouGTUcv2Jo0m5XesQ5XeOtfGEU5skh6Uk=;
	b=TbDYLdOVGG6HtwHKRWETi/4fIGyb8m3Wzn66k6eMJrtC6SO3eyPZGbxAstEloXXjIYjh
	 GQ00WiNnUJpptxdeSj8xERFxEs7g79pmoyF/WXg+0jAMI1Eh0aKNICAYv0zni65sCL8oV
	 JTW2UfXLOgvQMNK0pKdod7alCQ0V2erPA8HXB1Wxr9uJOo53RyCXXwbS0IsEcZQf50BBM
	 NRNhWZzMECvam4bqwUL3auuP+ojWf4Vtzjo7jwPmtP0wgkgoS4gxcJkikaOG/cOLabB4V
	 3Mw5CKmyDbMw68katuP9p3O5/bg83GRnCXioAPsfhdSuQUnz03NYbJnSa8xJ3j14uMw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZFCLO7XD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790527577;
	bh=Id3KAcgrwFouGTUcv2Jo0m5XesQ5XeOtfGEU5skh6Uk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F7L4/Ft6qvo366xtP1Z0q0CXEwYFtzQuMF1RaF9Z7/pLAfqDn/YMPCEQcs3i3D4W7
	 OiDGNP76jRIw/X6hATa12pzJR0/v8UmdbeGZuWE1eQ2V8tbmLsC6smGoxf7tSfjNpZ
	 R2KqqauUx6zC4gB3o2bE2KDvXWjke44quW5jFyzK5jo7PCWjvpUnIeZiQP/eptZdte
	 DDvyAeFORKUM3c+fJVocKT8R+5jPlEEQZru6iuFsY3CVKc+7c3FDsbzdmt4ugrbkVa
	 QEE1KdrXi5CnvEdUi5tjuUPRX6KIgEHCQJw3BTqpWUHRqUnr4RyrgSIvl7tpo8NFBZ
	 uXnQMCiLVxpSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D12640695;
	Sun, 27 Sep 2026 16:46:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F056F22B
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D659D40695
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 884GkbBg1r98 for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 16:46:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0CAD040467
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527575;
 b=m6os+QBkrO8dLm0OX4+RwU9D8IOqXaOz0d7mrKK+TuvGXPD2Yn5y9Whf8UVEO8Fm/nT5
 Mz3mxl0o1WfWBud/4tBT+Uuz5iwWmukHIxdfN87mxPNi0Q2hCMz7+jAWYQokKa9LD3lKk
 UtwYh2hDFkIU0A0rTsFC0BG9poBB4DZmj3uYf8Ezgtf2Rz7vaUGzgdQs8DiKEZJgw+Zyb
 0jZyyIcATER3pmsyfCgJwnhD7P6JSs00iUZgxQYU3+ay/e8QtxVu9eAskfRlJp0DgYDIF
 XP3G4n8kq2vq2/YKY1dY4J3+57wPJtc2oKsAL77DwsSFkhNIgRD2+JmBw3G8hSUgT/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790527575;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Id3KAcgrwFouGTUcv2Jo0m5XesQ5XeOtfGEU5skh6Uk=;
 b=b+bAs6ilcrjWFHdEHizS11Es2YUvtPah7+fgfpzSatgLieeNjny/DApzEDuxanPyypmG
 JNNvx+Bqgs8VhR6+3KfWme7ui1N/Euyi9872VFHLs7IY3Qx2ysugD0N5akIODsm7ZZRCO
 YZh32TjU0RawCuvBgyAty9bsO1HVSGz92f2EPDpNAR7b2CHSbEL9xzoTwfeilbturg0wi
 JRUW9rhFkrh4oYq3+7+gLXwTDh/OKswkUgdGEi92vmwU3Er0asQ3KvdQuWLCUg90h+Mj2
 ECbu5jhdnmrQmh+Pky19FOVnC1cwT9tL9EAdBpdynR+XVZaLh4ewuhKSZBAiPHJ1V5A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZFCLO7XD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ZFCLO7XD
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CAD040467
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:13 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a6056ac81fso3142302a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 09:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790527572; cv=none;
 d=google.com; s=arc-20260327;
 b=YxgnHJDl7adPPw/oaG5/SfVBj9pz78kC5SOBPXsgZqY0NTZEp2j0OsNkR3PzF4Cfr/
 1zgBxthId1LkKf3/n29eEkzA1i/5q/1the5yHBWssRFCpNeKUBEvOMS3Wul9aUOgai7s
 fn5gKyJW6QUn0VQypKN5C6VMyCkvPd7qVBkP2bAPYKED7+GZ9zDZcEBMeCOe3zU8eiBg
 OjAchjDmSQSGVpHsrxvgq65rMv/Q7pDi6drRBHD4g3hFikMITaKHZFcCR8FW5JyjDhVh
 p5ut1SG3fCteDz6dypo0VXicw6MdRtw7CnAPPdycdjbgEqjC+2IYOWABHG7yy7IXtZd2
 30Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Id3KAcgrwFouGTUcv2Jo0m5XesQ5XeOtfGEU5skh6Uk=;
 fh=4B7FMck9Ngx9nuOmeSA6fGRXQa9ko6a68e21FCCuDm0=;
 b=lYcjulYpEuWsBT2oEJlon+PDDjc6ygEcRx1tCNoWo8lHQyv8ml/Umi3AEp2GbKaUJE
 Q3S57E3P89HUojqUtPDggknhCb/lV9hyYXM7r068MMBj1RDXDhOwHJkqPPeuGB9ZCzGS
 yjIyBFlscfrt3oOVxVbKkJQdlD9Ezu9TpNxQaqwpC39lbpTk8+xoxcuOxgsUiB0NZaR6
 5Za8SndBp8FJpY/tX6YaKcgjStqs0scuMI+KDQD1MtKj7maXCULDgSzCQu9zBHbszBEH
 rH36u90Dm6A7SFMhEN6DdU9MI72zT74VKOOHFiWXm8+HWAFLenHAzeLzgW6dtqJ7Pc6x
 /TVQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790527572; x=1791132372;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Id3KAcgrwFouGTUcv2Jo0m5XesQ5XeOtfGEU5skh6Uk=;
 b=ZFCLO7XDe2RicMHOG/oN/OEglAGabRts9FgDISZkUqZPvFpOUrzCMN88S4IiMmUO+K
 51U6026C9ag5VVvr+7RspzGv6JtYfM2u1IDdAC3M9cTJnFiJ0V0RiPzQHUkTxrL4ONW5
 6Zclv3lhSokKIjjthRDTEBwmRrXdJbnMe8cP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790527572; x=1791132372;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Id3KAcgrwFouGTUcv2Jo0m5XesQ5XeOtfGEU5skh6Uk=;
 b=H5DprE0FFCFj7dWGjRUwRTuCAg6mmlLII7VyVakeG/Fyygyjq22iwesgTQoyOSFOLX
 7FTayfZlaB5MdBJ1nSbStZaNmoZ64BOR4e4uTn1oUS7eLMu4rUYr+3S/Im7uhCVFSylG
 8oGab/CCIrzVnuVdBiwK3ksjdqpIUFq21kEM8mIeyFpB8EzOh3Fk7QwnGvjt2Wja4LWd
 KAtETjZ0b0KggPW/JGW3b416LFKOJzX8/YYgoIx2YmSJlwqUDtcjuRAeg3BPmW1/Zt/a
 g5g6/rWpphKgtPYxNKbrPFDb9WsLBFejT/+rt8e4yR/en34kVPc8utyvJmrHi056K59m
 fdQQ==
X-Gm-Message-State: AFq9FYJX0GnytqEZG5tM3WInIcNsxWYPHcjnqZnPUn/IgDQwI42aqt8B
 PmQsNSPySSo0GfBARZjauZpiycEm1dNgmAHN//rUqF5uzK/K9Rvj5XCmydyI7dfmM/vrA9f0U4A
 QbuLlzW9VpDjLyZWbwCZDIB+/ZQllbySzx6oDwMimBseZng95BP8=
X-Gm-Gg: AYBFou2uYv5twKrhq7K4eosRiL/24OEm5VOFHY4+Nf0QWEj8mI0WDdza0jJ2uvpX/gO
 z6UyQ77masmGxZstC3mYm8lElio/V/610uyGUfN2JyqTxlYi1Xb87uRC2cjfU8frA+j/yhm0Ems
 r3I9rtws/C7l0NZvk+GIF+QVlShxvNKuuu2tNEOhCPel/qc1TNigJMzbdQxbpHGgQmkYLmWXuGG
 ppG/dW2EZwiD+qLgcfFkUzr8KjhKny1E/HJL2Q4u5HpHtqNn7kK6+Er7GVPQEqjOZeNddPcJ94Q
 SzZXkwoleqAsq4rjrzb439Xk6mZzSGkFvxosWmCEcGI0r9WetURBmg==
X-Received: by 2002:a05:6402:3059:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6aac8ed43a4mr7007372a12.5.1790527571604; Sun, 27 Sep 2026
 09:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260923154610.339153-1-aristo.chen@canonical.com>
 <20260924055459.125648-1-aristo.chen@canonical.com>
 <20260924055459.125648-2-aristo.chen@canonical.com>
In-Reply-To: <20260924055459.125648-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 10:45:55 -0600
X-Gm-Features: AclHuK9dZzkJpZvD324O7a_3DvwnKCIZ8GnDxWvi-YtJ6l_lbL_FxWvpdk5c9ko
Message-ID: <CAFLszTgktncjuZt-wrWx=CYA0itjcFAMKsHZdPJzXM3RcB2DsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tools: mkimage: use FIT_ALGO_PROP for the
 signature algo property
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 quentin.schulz@cherry.de, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-09-24T05:54:48, Aristo Chen <aristo.chen@canonical.com> wrote:
> tools: mkimage: use FIT_ALGO_PROP for the signature algo property
>
> When the signing algorithm is given with -o, fit_image_write_sig()
> records it in the "algo" property of the signature node using a string
> literal, while fit_image_hash_get_algo(), which mkimage and the
> verification code use to read that property, uses FIT_ALGO_PROP. Use
> the constant for the write as well.
>
> No functional change.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> tools/image-host.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
