Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692F606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bFY9shGe;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=N0hufBOS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DBD8608B8;
	Wed, 18 Nov 2026 10:10:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TxKZCWTwCPig; Wed, 18 Nov 2026 10:10:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97F5360860
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794996655;
	b=HUdzm6STGfIR/H+cGxpF6FAygcLkSZr0FACYOoGv3anqQB3weW0NIuU7+MwnAx2fEF28
	 1FRyx0T7f63htL4P1+Wl1IA6mmtWLBdy50zklanlHCLXHf9JHHaMu0yqa0XY5hff8Y6Ch
	 zaH/URo78LZagDQDLFyGE2uKaHTnnYl10rx3KNgmLMzJKGUz+wRhNXflvab7hZPO7uAZ0
	 +hAWKDfcBesE7rh8UhleN6JmCEfZ/NbrZsgTFxbTnKVtCONdxOgfXZ7prNUF80jcnb6cr
	 G/VeOxO8zULsyytHoqFtx7HiN2Toxqt4KxlwO5m5LmXINW67mY+GZbZrE4wRPBrtZgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794996655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RZtEWWghCTwsZP4uAS9NsNqmTsh2ZJtngpd+l3E/uO8=;
	b=V/qdRXDKuDVCG74AmrNShbRibVXdxIsWHJCy3otcBWFhpKwPVE1kSK7m0iWHWcjVB1n1
	 wiwJIWMHGnvKALXyjZVcF8gby8N4zDOE6iPTlG5U/5liVGCJh4KXFVCZWuPa8Wq478jiY
	 yvpiPdNebNgUNicx3O4sSAjUmtZA7PXO08uIYDWbI2h5A57tiYNIn7QB4R/QGejBqMFuA
	 f+gmV5KqxmwK2Igcuk9vHeh+ytPcQU8DiM8cBj+95GdLqCAx/eS+oHdZnp8J76F3zhYi2
	 CDzP5i1o5U9yW4XGHfHwDb/hMaIB7QEjrvnG4szwaUtXT7PpyPj/7UF575LK5niwrsA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=N0hufBOS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794996655;
	bh=RZtEWWghCTwsZP4uAS9NsNqmTsh2ZJtngpd+l3E/uO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bFY9shGeur6UAsnNg8sZXGAUNj6Yg2Em1DfZNlRqayn5QYITRKbSuHIxZUlfheQ5y
	 6a9SqPux8zkLIfreAb3sr3mzccB4GiJNrHzJBexhCuTWHiNyn/VKclhLVF34jaZJiK
	 LwAdHUBPiNhTXzfxF1QzhuQOpRhLW9+e+uIncIMZ8roqgd4kbjK9qRjQ5J7rk9ZB3v
	 20N/40co+s/ht5W+qoSM0ynm8aYKHqnXke94Ig2MJl9NeMCN+ahNQ+pHzoWjTjneUL
	 xzI2Na0T1lSuHfTP9vBJCXPcbCSNK5G8K05uC02pYwncMJJISPS38GZtBedh1gg8eW
	 4WuxjyaNVc8nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97F5360860;
	Wed, 18 Nov 2026 10:10:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7A38A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99B0260860
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:10:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhrfWxQdat8m for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 10:10:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E38760853
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=N0hufBOS
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E38760853
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:10:50 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-491846221ffso608320f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 02:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794996649; x=1795601449;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RZtEWWghCTwsZP4uAS9NsNqmTsh2ZJtngpd+l3E/uO8=;
 b=N0hufBOSqKHKCeqM6b0Bo07IQHgHCpIRG97OxCenxdczt7qm6uPlpbJ/j/ja6PK8qI
 sewB7R/cyeE1joxJd3o1Uls4lC+ipSXCEwXm84fo0cZtI0qgXiRdiXJRlJZ7VkqwiJsV
 u9YFbjzoafv2Dc04q01jpkQXwCj7c35zFhqaStdXNRar0Fip+cEL90Q2f7yvWfgUeenO
 eNZl7dyyVsMtb0hGY+cteT7dDs5Z8DKy1Bu/wL9gLlqFZ8YTYMnZRI6txQdVigzNUeQu
 GjAc4lxs36dCf0T7U7CuYLn3t3tvVaijgSzTxfD0AasNnuJXkw5t7c9xX3s3iaNJ7DsD
 Ziow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794996649; x=1795601449;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RZtEWWghCTwsZP4uAS9NsNqmTsh2ZJtngpd+l3E/uO8=;
 b=Yb3vaqbvnGOoJEdXITr2Zbe5PyLszZxxzdsd/Gl7OE6CnQZxoYZRxBdL00cXOwNWDS
 6q5gzovO8nX/3/HKMuqAlPgb2vQoF7i/LdjHKwDMBqdN8obEjky5FpHIjTfLSmiDi5hq
 wz3I+RPv6Az8l/t0b4FY2Ap6totzcKPtG5hVQqcNnxgrOzOBdZdF9ll4iyBqen20vfvC
 q06WqVA/S1zgWiCXtFBq5bGiMjr/dkn3mvIPblkSzWwjMwj1RG2bPcN/R9dpYnQDsvHF
 qpVR//77r3UlXsSmZPBH6D2tbLby7V0a9/mPK4kSGFffi5nNnsrtoyPLJyeMkfpw8/Oa
 p18g==
X-Gm-Message-State: APuU4Z9DJ4hvPhqTu7SFXmFzfGkUjy3WjHAefFEozfuTA5Qf33YxfXDt
 UdTUoLARAgSJUigK65RTZkV+MGe7TE5fwZBSRqiNkKBD52xX+rpl7jfNru2aC8Xg5W8=
X-Gm-Gg: AZFdTZfvkGBFpCro5J8Nyc0jqfrrLGnGroFhzFmS/VvGptQtOY+lb8DoDZomF2D27pp
 owJ+xRjkAB6R5dkFEV0A0Umv2CjF2nTaveMoPcv3QL2DZ7al/969hoWFoE/Ok2dwPQxEqNzr2ZO
 QmzDBPAqZDCBOUfsmJV30YlvKpeGgVr2jI92YAjjGUppGhqRfNqF6t93enSdnyfRe1Nq1+A5E/e
 N0Fei/WQQxK/7cR8F1i0+4dgrrr5tsHM1on0+mosnxbLJleMqbzKbmKe3oGcWGyG9bi8KlgdAdH
 lxPSI1pz4sqE9w0K0F1rvH28ure1ayzdLTN3MQ2UG3/gVLOPf8uk5ln3qEnGtp8nJWsGBYgG6m1
 rWBfJz3aaHcxQVLv75EnegAeQP3ID5sYq96jvQxD4UTkG33128z0ht6V/9+MzAezgyLzUxLu7HW
 2NDDp+Jc1vYzENTEHAHWdb8+WYV2jrXxNGE+sNPEbLu9IWXdFnCcuxzWkteAzzQl5APWfq6kQUp
 BglWMUX34NlqCHMHbyXWp+5LvDwbQB+XkFcz6tYDQKaECM96PewRoJQk1gbA0F3qS4p5dnUyfp6
 tClEFSYK5PMShIhlCr9dR66e9KsYhoKKes+Y2Jxczq598h59pRPyJ/vf+OGD2mml3bviLouvw2r
 rNLrcfcXSSeCGZ/FPNlQjlm6ICy9UuSNOMQ==
X-Received: by 2002:a05:6000:454b:b0:4a4:f208:6a37 with SMTP id
 ffacd0b85a97d-4a63c55e023mr2685321f8f.42.1794996648881; 
 Wed, 18 Nov 2026 02:10:48 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a655db6d45sm3756122f8f.33.2026.11.18.02.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 02:10:48 -0800 (PST)
Date: Wed, 18 Nov 2026 11:10:47 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 York Sun <york.sun@nxp.com>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Day <me@samcday.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Alexey Charkov <alchark@flipper.net>, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/6] Support fastboot boot in SPL
Message-ID: <av15VI9Zvz1rwNuF@macbook>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <179492230542.246593.14014203987510433850.b4-ty@b4>
 <av1KkSo_66l1C33S@macbook>
 <xhkdbv75upisp.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhkdbv75upisp.fsf@mkorpers-koolstof.csb>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 10:53:26 +0100, Mattijs Korpershoek wrote:
> Hi Carlo,

Hi Mattijs,

> Yeah, I did explicitely apply v3.
> Here is the history of what I've done:

Yes, indeed I also checked the integration branch and everything is
fine there.

> Somehow 'b4 ty' send the wrong confirmation email.

Odd, time for a bug report ;)

Thanks!

--
Carlo Caione
