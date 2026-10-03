Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5D0CA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90CE060666;
	Sat,  3 Oct 2026 13:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OgRty3LfUTKB; Sat,  3 Oct 2026 13:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D3D8D60689
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034836;
	b=H947B14kSQ9clqzvvHaiqrClds4MQmUhyyxhq0++q/vQeVLVf0sOXkX5cZiKaoaOZ8l/
	 86zmLxoVSwrN+e56PgEOoi4v323GVbcjrJsdJhyaItbO/1z/KNW0CzRscnPMcQzlGE5nI
	 s6HWMpl5+0+JKz2ONh0Vw9e1pKxsTRAGwqHzb4/E1SLUhgrgPMFJKKcBRGJSTu2p6tYF3
	 mtKIZS2rnLTAQNs7qryU2iF768HZ+vT3ITsS7ruKViBmXrmYbfS15xvcuwKuDXWlu0K7U
	 DXn8oTFu2hPe7GVO2G4i/0xxcwCI3Da1Y0qL/+breW20u46eMZZa4mjAW3UUZvCrh7w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034836;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FsRv3KgQ+5QXnT+pqKQR9tF27NS7+0I5WUCvK9P+WOc=;
	b=cxJwTU7z76etVt2YYA3YHTq2yLss2WoD2ELnyZxHf/+CAfMRpyhoevdHVzQFURM8jY4/
	 jtSZ0xLt8s25AKkGTWoCQjUX3jofGw1VkvjsKFJbiQAUCY35fuKAng1dh6oqODCsOfMut
	 kkilHF6UHNotLMBtyRcL8weV5vNeDI974VXjMHqtnhelsOK295KW7RtU5bQYQhCZFx3n6
	 I4XLxDhgnDrUBFCzTOJAgYzm6HstZ3CV2MxgGfPqQIH0AdNn5BGZOHeQSe+BjNn9CUwbd
	 XXkmsz4qN7KVKEEbKn8JXQUqZkPENvf1+RS0S7/kJR6RzIhiv9258AKyPGtWIzbueBw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034836;
	bh=FsRv3KgQ+5QXnT+pqKQR9tF27NS7+0I5WUCvK9P+WOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w/YBFzJBU71uI6HIJue3+b9CDV1/syXIP4Mem2ge6NR1tgVSdLa33xYUIdlNAVxui
	 x1Nol15a81xgnbzHSqGVhTfvVIs85feS2xreNFXJ9jU/KboBH5+wFJWlUa0ZYJYufv
	 a7sTTYHB1n85xECC5yHMRcCErR2siby0cR73OCsOFHC6tXKpp6T8ESSFrHMf/uAhK1
	 Gb0gK9PjiEOmyKt49ovnMVgxzoTkVgNVLnmhAB7BvglH0DR2bTyXMZuHT35xvdAL+D
	 E0sAXdES82BeF3rqzihhS9LQar2V8yHpsu+8iS//AcNah/dN4DWswEsPREzvoHU/Kd
	 kXSyBsWLk6n2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3D8D60689;
	Sat,  3 Oct 2026 13:40:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9FB7179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BD79813F5
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bA7zRE9irXeT for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:40:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9404E813DC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034834;
 b=d+PWFi1bbyBhkOAwA1Ct2oYEKfSKHeL1uZ/nc0/9KsWkYTSIvZOySMd3kZTBJqU5ovd5
 S1nDrg+r+QKTgl+93Nw4e0TXSv/W6t94RbnHdi9Bdhrv+gsSMqfxLaZmysRMu1AbxGUPt
 XU8AgYzLNg68x6EdR9Cxl+C07x7isUKbUD9a/7EA4LyYMFGNVDVw/zZcf02Q3reFjgIZA
 N/JUsf/Bc03Ys9sG/g1dIhbL38G/rdoaUYGmDygnaykLf0GA7Y3lpg3cT4AMkTN30LVcu
 X9NlO3CuR+yqHzAPzBRuQEUtXHMUf1F9PdgPPXXslhN3GsG9yAXtuFWqFiO7U4cmLfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034834;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=FsRv3KgQ+5QXnT+pqKQR9tF27NS7+0I5WUCvK9P+WOc=;
 b=ZONHiTNpmXhvmj48lXk6XsJR3q+SVpnyLXWqzgs7ETUDbEEYr++e/hOfj5Nw75f0g3EG
 7IJGMj5PDANxMoSqVWgUDG721NRsBGpyz2TSOlSYCa6z8DQeGkfIeHEeFEg12Wrg9X7uN
 aI2vZZQWrGe5yl1Yfk93+Rm5zkRR5qs+vna6/6fZ91qRorvYsrvBW8vnSLNIKeSYLvlOK
 YVfupzwAehZDdrCV9fMumILQxfvcpm0Ut0cWF5VJMZ89fouyJBjfU1UF2jfKorEioz/wM
 KrKqxRIyMMPdLmmxTLbTZY6VX7L1PoBPAS0FSpfKPr4XbW35p7soOK7SQtp+j2UaOjg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bwh76NnC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::d;
 helo=mail-ej2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bwh76NnC
Received: from mail-ej2-x0d.google.com (mail-ej2-x0d.google.com
 [IPv6:2a00:1450:4864:34::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9404E813DC
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:33 +0000 (UTC)
Received: by mail-ej2-x0d.google.com with SMTP id
 a640c23a62f3a-c2e3f641442so112380566b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034831; cv=none;
 d=google.com; s=arc-20260327;
 b=TJtaKIfCrNG1CTWxylnKP6sEtwjuTZ8jnY3qOThqeYsF4lxCaa9X/nK8h91RjR3VSh
 +arVDQ4b5wYQb3ZJpjTuTog+DQaAayWZGgWFk9lohTiJYSxwOMlcQ9XSnmU24qhFh2T9
 P+qRFR91g3R+UE8lxgSGB3YTZdrEknnkjwby8gTT5eNQ51Oz0yq/1N4yD+gozeSVwpIS
 NT/nVIiPoX5h4NCuXTeFqhu9stFxaFvvUsGVOBoVtpOz8oS5jrgzmF26kcIkJAt+p4TH
 +3zmRfUS1XKrrUXLgYlAmUHgDgi27gP4Zo2un+OMEw0GHJ+oICYNz/00m+zgeys8obUw
 Z1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FsRv3KgQ+5QXnT+pqKQR9tF27NS7+0I5WUCvK9P+WOc=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=Yeg5qb0eHLyFWlkW2RtrQE+v9FliMz6LXJQ84hwqJooeg+GoEtWsNGNK2UePptLiVh
 JvwcBBEORJFZxAzG/pHewDM5UJWAEcJ71awrLUx/X8O63FQcMlc/+ZLzddwFMw0OwdM5
 EWgjY1IHKpmwM/sc0zo28X4qamJyoanbjFHm6idnNTb0VZUnbSrWmnCi/ZX9U/7OF9aq
 0zoL7C5uHGs1E8aDi6sMn1eybToMB06WRhYiceQcak+QivKjgziM8mk9IJTpi0hfjWqa
 jzRA+8S5OGEa0ikU5p91jsOmjOw3VO8C63O9cfZzRhxXgM3xQM/KGTY+jJ88HbTQIBoo
 53lA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034831; x=1791639631;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FsRv3KgQ+5QXnT+pqKQR9tF27NS7+0I5WUCvK9P+WOc=;
 b=bwh76NnCIaTAuhpTOCBZecbgVT6ts9bEZ19nf7/y2IIJMILE6jmVt7Xncb1qFkhQwS
 x70QX8y8L0BXLNbsq0Fz+X7/CRi+fZlan3zY/li/WUUXYGus93Ax6SpAcfA4PwyIcO5C
 vxAkbfI/aTPgFZKA40suSFhDF7ctu/xdy+ko8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034831; x=1791639631;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FsRv3KgQ+5QXnT+pqKQR9tF27NS7+0I5WUCvK9P+WOc=;
 b=aNUiWXvkKkda7m1cNjODJUC9baHh9PqDwcNoAUwpKfldIyntj2Dph6vMtnCZUFwoSv
 DAfNgARwjj1vVaefzfCXbXe1OQCJ2qDF6X7vAtMnR4Ucx57MJsJg1j99rQGCVSifDSlS
 +gouuYzAM0RV+VZiGhwQe9qohqqUjzBd/AefkBW6vrZAYWHEYMxuTcIumvTL12tuvb/C
 FBxRw4SL9zx/bQi6SdX5qdp7V1z/p4gAh/dSyj9jz4fbqcxdz8JwJ4sPQv11NsMOrZaq
 N3ywtE80e2C8NnudWdMon+BsdVFpgQPkLWDhecIlcvg3FaX9PIDtDHZDlOJGWQwfPnwh
 hyKQ==
X-Gm-Message-State: AFuF++mQ+DUnwVjj0T7hUDdi0QDnCsVOoCIMDIOc9uCIJd1CxlQLLfCC
 76ooIMuEWiAP/PDaMoYjPBNhBfZEFHhjCHb78QVo6V4SOkmTCrJCjiQ51NTDTS3HegAmhPMfa/Y
 eKvFuCk4xlROOJtzXMCdN9eluHkwXB2wlmXjQfA5u
X-Gm-Gg: AYBFou1iuoYF7Xl0ZnD+cTrHst36Ba4bEBgZmbOR8RJThVkjuX28RsWv6khb0zvU0nl
 BO6GrgN2rtpKUAdHr+mG4N8LUmcQKmSCkVr/pzxCmVfiUQeDyQP+sqDYNuMIjAgv8t9fymj7b43
 0m05UAkkFRUp+1u8+rIfXTS9xl366XJ7CmiQVfNbpUWTwwVsv+n/hj5bcefr/He9se0yf8EcaP6
 sm51UeyUnO95iZWf06a/73DpsIkHjIngIUo8oIlDas996cfhzKK0IvzGamg0Dwdh+W2c8TMq33R
 9nBxY87bixTRuqlgVXVa3Nn7T3j3Gy2Xw8IQFHJvct6AzmoElzL0hphV6bKAMACfbg==
X-Received: by 2002:a17:906:ba82:b0:c2d:e548:3ac with SMTP id
 a640c23a62f3a-c2e4ad9f351mr496029266b.19.1791034831484; Sat, 03 Oct 2026
 06:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-2-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-2-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:40:16 +0100
X-Gm-Features: AclHuK_4u7bv4vD9AxhCki1KPQtlyjbjs0c_72v5bsLDhGjo6jWqkeXti0j9B5Q
Message-ID: <CAFLszTgAZdmjrQ8qqwS=1LsXasXuH5Y43MA+9E2OdKeq4C+h5w@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] lib: Build xxhash in the SPL phase
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
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

On 2026-09-18T10:52:27, Alexey Charkov <alchark@flipper.net> wrote:
> lib: Build xxhash in the SPL phase
>
> SPL_ZSTD selects XXHASH, but xxhash.o is built from inside the
> ifndef CONFIG_XPL_BUILD block, so it never reaches an SPL link. zstd's
> decompressor calls xxh64_* from code that survives --gc-sections, so
> today the option only builds because nothing in SPL calls
> zstd_decompress() and the whole library is discarded. The first caller
> would fail to link.
>
> Give xxhash its own phase symbol and build rule, the way the other
> compression libraries already have, and note in the SPL_ZSTD help how
> much heap the decompressor wants, since that is the other thing which
> may stop it from working.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> lib/Kconfig  | 10 +++++++++-
>  lib/Makefile |  3 ++-
>  2 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
