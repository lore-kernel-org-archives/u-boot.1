Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BE606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nba3x5et;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZZJLY8o/;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J4efZkRp;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZZJLY8o/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2191540A72;
	Thu, 29 Oct 2026 20:25:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kOvtEWOgdc7i; Thu, 29 Oct 2026 20:25:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E1EF340A67
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793305523;
	b=Z6tfdvIIigp1RsUoOAwpAs2xabC3SfplRP+2qlM4hx/sCDGO3k4O60o5blpoAugnUY16
	 fcLgcPxJ85feQPQgvxEjKwG6LyAvFp1bxhiew9dwC4rrJeaHAYkHADWOz9Kk9yxTYC2xQ
	 9DwyeeaHInahEsGllH0XGCo2Sa1/D/wSYXkssGa5yBOF2Fizpct+ZzXA6kwMQYDHS9r79
	 pu3Z3s824Gn504taKFZ/GNXMOI+PygawpQ4wxDMruM7r/QUE5wKMjD1CgwewcLdcInMXf
	 0DNwjgJfx/IS3M2qRqIjbmOhuEahaYnZKnyOTI6bmqmiCqLyWhSEryB5mcO3tczsldg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793305523;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/W943XieWPxp0nO09+bYfQ5yhV/wgYbfeZpNuJXGi2Y=;
	b=XMuU+LVZIId4XFfuQ25hOCxSZqQlV1PUI+fplc7EU1D2zvfO23Y5TYPb1y7yLh1m8z6z
	 SYjEQIjGhIHQ1LtXYTCaIu8BpR2u3LgPexfft+ZB2yYJ94WfaE5L268vCQM9z4JCRd67b
	 5iEWIKlKJEPiEtgI4Vo56MihnyDL+vyzKBUlBnDQcVzdQ6dNYC0Z8Ay8rcuPh1x8B6+e7
	 1VbqSvkDPNeZ/oamnSbmUkDwmDxQyhH4RVkQC8v3vZGawgqR4QcfFyhKgETruQNhc4aAO
	 ETB44gO5qeOjQg8F4wOOu22ouKHdzH/WCTCA44nsXzpBFbCPA7v0d2bCsuH63p6hwTA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793305523;
	bh=/W943XieWPxp0nO09+bYfQ5yhV/wgYbfeZpNuJXGi2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nba3x5etVqsbKaqdhPDhzMRd01qqq62ovyeduOWIIqCXrhPfmm+KxuEVgTkcNpIHU
	 dbpRhnZsmTsW0Wp0Gfb+2aybV6DJvnKhBn8ZrGePU9vXbS0TzxE0CefIZposrftpnM
	 7Db3hhNGoGuzKY8lVUfP5dXiFDs6rub8IYdKWGmtI3oal067HrmrbMTIKQBa4JEs7+
	 AC5BTiCxkfgekd25XHh/1ms9Z7QfM7f6otIheGdcDTOVpFN/CUlZ7VGUE6cNZxdEs4
	 NRVAZswSqj+lEV7A8J/Bs9/TeSKm6UUavAou9l94lfEF66izqw3Mn6qdALCK8DZ18q
	 PVNLpyd0hjEEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1EF340A67;
	Thu, 29 Oct 2026 20:25:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B59BB362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A775760A70
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nwmVoTLhAEKh for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 20:19:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8B2C606B0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793305145;
 b=APmoEAo5Ppm34NHDWWRTbgHK7LNLccKo43V/SR5jIyyqYAADua31iMNCp419g0YMAeZX
 F+YaQck5hzWHq7uVhBMLbKrSLR9TbCJPUGfMPrcyiJjOiu+UOVqVoaEE7jOKaLY1A0uzR
 oYzdBgvqP0+OxfwsZA7SsC3oTkaMPAFUbp3WAQv7gVMXUaZ7oXaoGEkYEWG8/KwYYbePz
 dWw8GeXxJpRbA9ds4dQwDth+tEkqeM+wXEwu+eVXyQCz01y30ajA8k2wR/RD1Ds/XGRNw
 QZgqAq3/GmqanNG3saCw6vdrPyjQFYCsy5qYzEE2KEwagD2O75tsGQz5g3kqsBM/log==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793305145;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:
 X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=/W943XieWPxp0nO09+bYfQ5yhV/wgYbfeZpNuJXGi2Y=;
 b=XGOWjREfVYOs2nC1l8BqtVa+gu3KZtN7DQ4xAsD8ccwedFjFMLgzlnNMcHZ335Bn7VV1
 XEdfa5TX958y39NFSuiwKIJCLxKlOonM4qpoJd9jlT0OeGemc+AbxcYp5D07Ujzmzrm9x
 f4uWBgjdWXjpoADgqthoV0pLvNRjBPUrrKib4FdqFtsXTvsAu7lBoF84Xf2jdIYw8KcMu
 w7dhx7X+q65UMb61/ifO+WZ53kVpaYeZAA241tAdOj7OUOuHlIDRf3fxIAiSM/bhQs9tZ
 kKnwFa76J7C2K+n43h09CiWl5vwnQgH+YQzVvkFEqCpKTWDJeJR+kabIWALitTEPxfQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="ZZJLY8o/"; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=J4efZkRp; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="ZZJLY8o/"; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ekovsky@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZZJLY8o/; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J4efZkRp; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZZJLY8o/
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8B2C606B0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793304841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/W943XieWPxp0nO09+bYfQ5yhV/wgYbfeZpNuJXGi2Y=;
 b=ZZJLY8o/PSVprf3GGjGjuZG3qvPhBB/RTOMXbmSyNKUwkURWujc3wU/bCw6GU+zui4888u
 MbXiwZpu18hKe7vaPaRpCHYr42oN9TrKj05vCN+lwYSQ93DxEmUM231BqXJaQ5RaGhd8AZ
 he0I0/VhmKJNYTRcgxlwp/ekAZE0/ho=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793305142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/W943XieWPxp0nO09+bYfQ5yhV/wgYbfeZpNuJXGi2Y=;
 b=J4efZkRpRX7dvdo7WEL1YaGymCxLud3EwD7ymy3rBdiY2PgFMDKspLvbs0Jn76IoUyDGfq
 0Bs6NIX1O7Y32Zm/95c/4DWPCpxctyw3RO3n41RIDMo+MmAmqK08lx5d3l4MiPa9WArC2V
 qy6ZvdXsoyLKaB8XS0pGT1RcLZRu+gQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793304841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/W943XieWPxp0nO09+bYfQ5yhV/wgYbfeZpNuJXGi2Y=;
 b=ZZJLY8o/PSVprf3GGjGjuZG3qvPhBB/RTOMXbmSyNKUwkURWujc3wU/bCw6GU+zui4888u
 MbXiwZpu18hKe7vaPaRpCHYr42oN9TrKj05vCN+lwYSQ93DxEmUM231BqXJaQ5RaGhd8AZ
 he0I0/VhmKJNYTRcgxlwp/ekAZE0/ho=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-QoWwnFUaOMKxKMKLITfgyw-1; Thu, 29 Oct 2026 16:13:58 -0400
X-MC-Unique: QoWwnFUaOMKxKMKLITfgyw-1
X-Mimecast-MFC-AGG-ID: QoWwnFUaOMKxKMKLITfgyw_1793304838
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c71966998so323546d6.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793304838; x=1793909638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/W943XieWPxp0nO09+bYfQ5yhV/wgYbfeZpNuJXGi2Y=;
 b=qEnPVj7H6ouWiADP9cbIqN536Ic6h47KaaASZfYqJ64T71cVcNs3l/8wxNiLmu2+jg
 Ck93rpdaFW4+HFuOOP0pfDop3IkUtpNqsmJLLpM2pH717tUyoGt71L3D0pv0zwcVeVol
 0m+GW75xbzkExH1zoS4bYhVjIUvfV7FSQaRD0IEzjLFQazqBcDet5jTwOfnVXxihxaLy
 93heQF7teqx0SrbVqoKZ5TlmsPpr4Yy1qBdOoYGxsN4kSU7my3kwmaGqpQUvvntxNAJn
 FRIlt4lRAlHioG4iVdqTTl3eECKdTqfnDSQhilVj1eldbJU/+RFaeaUfiDVDFbPjDg9P
 sR/g==
X-Gm-Message-State: AFq9FYLJsMOZPH2Npyls4E1vIlxtcm7O17JlYh7hcCwfivIlWXVemk37
 70+xl1wy9GSGOdepRzXp7tSiMPMWiOJgZuISdnAIcSVkQmJ4sEoRbOf7c+352P+jlHNpqiwDiUQ
 +n/THboHBAP0HBHBv0OWG5Ti3npk5nFtjgIwNXmt93BjrnX8dzsHJV0ndBXe5ja39MeNc3g==
X-Gm-Gg: AYBFou2eGPQexq1YCUgdNpz9lmxcDpSz2d63B/UmwoOhixRpdi63fp0VOiplhYTkRj1
 6Wc0u341IQzxcPTLfdFemL4rYzCi5pWrVqmUDEzHMIpxoIdTWHb7oB6HrikZEwW6napJHxUnzM/
 /T/9y7Ns5Ov8DjSElYtxf/o11XjwKUtBlgeOmNX9wu1GJogjU9nYUCvln/yhNNZHqzxK6P4Pc8+
 gACuyjg9xUThRLav950ErBzh482YZXSP4isJ2dMDckjnku5qxu0W8eR6/Xr/3Z9nj/4YBlm86FC
 CyNvLwI1HJpHmvX5N3n3OHUFe8xUBFyvGcGGRYSXG4SmXttFor54cveFIudOOWu53ocmaQHDn9Z
 1jyNmR0oeOxkbnQyyGrYzKeWJ18PObCo6rvzjSW57yyA=
X-Received: by 2002:a05:6214:27c6:b0:917:9743:9d07 with SMTP id
 6a1803df08f44-91ca4a13d5dmr1285146d6.1.1793304837524; 
 Thu, 29 Oct 2026 13:13:57 -0700 (PDT)
X-Received: by 2002:a05:6214:27c6:b0:917:9743:9d07 with SMTP id
 6a1803df08f44-91ca4a13d5dmr1284556d6.1.1793304836820; 
 Thu, 29 Oct 2026 13:13:56 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca3104d50sm5017826d6.23.2026.10.29.13.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:13:56 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
To: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Bastian <bst@pengutronix.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: [PATCH v5 1/3] Add support for OpenSSL Provider API
Date: Thu, 29 Oct 2026 14:13:41 -0600
Message-ID: <20261029201348.730274-2-ekovsky@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201348.730274-1-ekovsky@redhat.com>
References: <20261029201348.730274-1-ekovsky@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1TbxL0lxLZN4nMtUGPcMotX2yA7PxZOTWAsz92cfTyc_1793304838
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Thu, 29 Oct 2026 20:25:16 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the Provider API while continuing to support the existing
Engine API on distros shipping older releases of OpenSSL.

This is based on similar work contributed by Jan Stancek updating Linux
to use the Provider interface.

    commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
    Author: Jan Stancek <jstancek@redhat.com>
    Date:   Fri Sep 20 19:52:48 2024 +0300

        sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3

Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
Tested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
---
 lib/aes/aes-encrypt.c |   4 +-
 lib/rsa/rsa-sign.c    | 102 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
index def33a3b3248..0cb2221df800 100644
--- a/lib/aes/aes-encrypt.c
+++ b/lib/aes/aes-encrypt.c
@@ -16,7 +16,9 @@
 #include <openssl/err.h>
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
-#include <openssl/engine.h>
+#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
+# include <openssl/engine.h>
+#endif
 #include <uboot_aes.h>
 
 #if OPENSSL_VERSION_NUMBER >= 0x10000000L
diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 0e38c9e802fd..361ed0647bc6 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -19,7 +19,47 @@
 #include <openssl/err.h>
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
-#include <openssl/engine.h>
+#if OPENSSL_VERSION_MAJOR >= 3
+# define USE_PKCS11_PROVIDER
+# include <err.h>
+# include <openssl/provider.h>
+# include <openssl/store.h>
+#else
+# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
+#  define USE_PKCS11_ENGINE
+#  include <openssl/engine.h>
+# endif
+#endif
+
+#ifdef USE_PKCS11_PROVIDER
+#define ERR(cond, fmt, ...)				\
+	do {						\
+		bool __cond = (cond);			\
+		drain_openssl_errors(__LINE__, 0);	\
+		if (__cond) {				\
+			errx(1, fmt, ## __VA_ARGS__);	\
+		}					\
+	} while (0)
+
+static void drain_openssl_errors(int l, int silent)
+{
+	const char *file;
+	char buf[120];
+	int e, line;
+
+	if (ERR_peek_error() == 0)
+		return;
+	if (!silent)
+		fprintf(stderr, "At line:%d:\n", l);
+
+	while ((e = ERR_peek_error_line(&file, &line))) {
+		ERR_error_string(e, buf);
+		if (!silent)
+			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
+		ERR_get_error();
+	}
+}
+#endif
 
 static int rsa_err(const char *msg)
 {
@@ -94,10 +134,11 @@ err_cert:
  *
  * @keydir:	Key prefix
  * @name	Name of key
- * @engine	Engine to use
+ * @engine	Engine to use or NULL when using pkcs11 provider
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
+#ifdef USE_PKCS11_ENGINE
 static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 				  ENGINE *engine, EVP_PKEY **evpp)
 {
@@ -157,21 +198,24 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 
 	return 0;
 }
+#endif
 
 /**
  * rsa_get_pub_key() - read a public key
  *
  * @keydir:	Directory containing the key (PEM file) or key prefix (engine)
  * @name	Name of key file (will have a .crt extension)
- * @engine	Engine to use
+ * @engine	Engine to use or NULL when using pkcs11 provider
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
 static int rsa_get_pub_key(const char *keydir, const char *name,
 			   ENGINE *engine, EVP_PKEY **evpp)
 {
+#ifdef USE_PKCS11_ENGINE
 	if (engine)
 		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
+#endif
 	return rsa_pem_get_pub_key(keydir, name, evpp);
 }
 
@@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
 		return -ENOENT;
 	}
 
+#ifdef USE_PKCS11_PROVIDER
+	EVP_PKEY *private_key = NULL;
+	OSSL_STORE_CTX *store;
+
+	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
+		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
+	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
+		ERR(1, "OSSL_PROVIDER_try_load(default)");
+
+	store = OSSL_STORE_open(path, NULL, NULL, NULL, NULL);
+	ERR(!store, "OSSL_STORE_open");
+
+	while (!OSSL_STORE_eof(store)) {
+		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
+
+		if (!info) {
+			drain_openssl_errors(__LINE__, 0);
+			continue;
+		}
+		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
+			private_key = OSSL_STORE_INFO_get1_PKEY(info);
+			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
+		}
+		OSSL_STORE_INFO_free(info);
+		if (private_key)
+			break;
+	}
+	OSSL_STORE_close(store);
+
+	*evpp = private_key;
+#else
 	if (!PEM_read_PrivateKey(f, evpp, NULL, path)) {
 		rsa_err("Failure reading private key");
 		fclose(f);
 		return -EPROTO;
 	}
 	fclose(f);
-
+#endif
 	return 0;
 }
 
@@ -226,6 +301,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
+#ifdef USE_PKCS11_ENGINE
 static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 				   const char *keyfile,
 				   ENGINE *engine, EVP_PKEY **evpp)
@@ -293,22 +369,25 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 
 	return 0;
 }
+#endif
 
 /**
  * rsa_get_priv_key() - read a private key
  *
  * @keydir:	Directory containing the key (PEM file) or key prefix (engine)
  * @name	Name of key
- * @engine	Engine to use for signing
+ * @engine	Engine to use or NULL when using pkcs11 provider
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
 static int rsa_get_priv_key(const char *keydir, const char *name,
 			    const char *keyfile, ENGINE *engine, EVP_PKEY **evpp)
 {
+#ifdef USE_PKCS11_ENGINE
 	if (engine)
 		return rsa_engine_get_priv_key(keydir, name, keyfile, engine,
 					       evpp);
+#endif
 	return rsa_pem_get_priv_key(keydir, name, keyfile, evpp);
 }
 
@@ -325,6 +404,7 @@ static int rsa_init(void)
 	return 0;
 }
 
+#ifdef USE_PKCS11_ENGINE
 static int rsa_engine_init(const char *engine_id, ENGINE **pe)
 {
 	const char *key_pass;
@@ -380,6 +460,7 @@ static void rsa_engine_remove(ENGINE *e)
 		ENGINE_free(e);
 	}
 }
+#endif
 
 static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
 			     struct checksum_algo *checksum_algo,
@@ -480,11 +561,13 @@ int rsa_sign(struct image_sign_info *info,
 	if (ret)
 		return ret;
 
+#ifdef USE_PKCS11_ENGINE
 	if (info->engine_id) {
 		ret = rsa_engine_init(info->engine_id, &e);
 		if (ret)
 			return ret;
 	}
+#endif
 
 	ret = rsa_get_priv_key(info->keydir, info->keyname, info->keyfile,
 			       e, &pkey);
@@ -496,16 +579,21 @@ int rsa_sign(struct image_sign_info *info,
 		goto err_sign;
 
 	EVP_PKEY_free(pkey);
+
+#ifdef USE_PKCS11_ENGINE
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif
 
 	return ret;
 
 err_sign:
 	EVP_PKEY_free(pkey);
 err_priv:
+#ifdef USE_PKCS11_ENGINE
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif
 	return ret;
 }
 
@@ -645,11 +733,13 @@ int rsa_add_verify_data(struct image_sign_info *info, void *keydest)
 	ENGINE *e = NULL;
 
 	debug("%s: Getting verification data\n", __func__);
+#ifdef USE_PKCS11_ENGINE
 	if (info->engine_id) {
 		ret = rsa_engine_init(info->engine_id, &e);
 		if (ret)
 			return ret;
 	}
+#endif
 	ret = rsa_get_pub_key(info->keydir, info->keyname, e, &pkey);
 	if (ret)
 		goto err_get_pub_key;
@@ -726,8 +816,10 @@ done:
 err_get_params:
 	EVP_PKEY_free(pkey);
 err_get_pub_key:
+#ifdef USE_PKCS11_ENGINE
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif
 
 	if (ret)
 		return ret;
-- 
2.56.0

