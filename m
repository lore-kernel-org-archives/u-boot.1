Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29823C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4915D888FA;
	Sat, 13 Jul 2024 15:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZsdNAxzP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a3pPgOrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDAF58891E; Sat, 13 Jul 2024 15:21:52 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A1AE888FD
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpyk0f6mz9sdG;
 Sat, 13 Jul 2024 15:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTnLWIPI0DClSlT6J3QwSs1YBo/R004ILgqGMpvCJ04=;
 b=ZsdNAxzPd4Sx80xAJRT58am+tIWXHnoGmDvhZRAaJbQSreNBv9AgK2UKgWOtzajMNOLWup
 m4Ogczp9Gg668nPXQXM2hV2gB+9bKg3nalSNaxLN/u22gd5g3bXxF+2ieTZajQ2s7+VQkP
 0LjEvir89k5Ap+7hjFHwPjjT07Pnni6DidvGb18e4v+gOZK/qQr6iHmagEHcS+kOnZJ0ho
 ZFiqiEOD5BbkV/kmCe6lJVkG3gTkmCLYRCv8d+LP90gEDTH+Kw+XH946LNHNMNXlvH12iN
 y/xRbHDFbkgSaJnoOVgZEivHpHrD5mDlLR7IZFspN6ysPWpcvYqVQ6eMk6k6gg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTnLWIPI0DClSlT6J3QwSs1YBo/R004ILgqGMpvCJ04=;
 b=a3pPgOrdmx1i2RIK3Sr7+iju6qZaEa+NnGr2IYGiphi8lACcU3vgLXPU65iPUmxnMhww33
 vtx8cctr8S/3Zakz4zAVY4UwaDNxEPKLm5ke7sVLWsSAbCfMgD1QUtwz23/r2I1x6/PQwN
 cb2jgNNkHR5CwQIbdEflCZyrDqHvqCL5D/lCTjWcuN3e9JC6nXSF6/f5YqXm106Tap9H56
 GLj+/UJHQdFRuuPU/scoIDHB6SNq3td+JeU0Sg/aOJ06t563fEtPixGePQeY7H+3AuNP/P
 kHGfbdpYR0bNH5ClFXvfGKItsGi5TrfVz+8Ah81CzzK4Xr1iCbT7bin2QjcNnw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 40/45] scripts: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:31 +0200
Message-ID: <20240713132021.57650-40-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 56ae32ec54745ba6c42
X-MBO-RS-META: p6asfxa7m8q6hqbciito33pgyi7zpzyh
X-Rspamd-Queue-Id: 4WLpyk0f6mz9sdG
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 scripts/dtc/checks.c               |  2 --
 scripts/dtc/dtc.h                  |  3 ---
 scripts/dtc/flattree.c             |  3 ---
 scripts/dtc/libfdt/fdt_ro.c        |  2 --
 scripts/dtc/libfdt/libfdt.h        |  2 --
 scripts/dtc/livetree.c             |  1 -
 scripts/dtc/srcpos.c               |  3 ---
 scripts/dtc/srcpos.h               |  1 -
 scripts/dtc/treesource.c           |  1 -
 scripts/dtc/util.c                 |  1 -
 scripts/kconfig/gconf.c            | 38 ------------------------------
 scripts/kconfig/list.h             |  2 --
 scripts/kconfig/lkc.h              |  1 -
 scripts/kconfig/lxdialog/dialog.h  |  1 -
 scripts/kconfig/lxdialog/textbox.c |  1 -
 scripts/kconfig/menu.c             |  1 -
 scripts/kconfig/nconf.c            |  2 --
 scripts/kconfig/nconf.gui.c        |  5 ----
 18 files changed, 70 deletions(-)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index c35aa6f8863..2feec44a0f7 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -111,7 +111,6 @@ static inline void  PRINTF(5, 6) check_msg(struct check *c, struct dt_info *dti,
 		check_msg((c), dti, node, prop, __VA_ARGS__);		\
 	} while (0)
 
-
 static void check_nodes_props(struct check *c, struct dt_info *dti, struct node *node)
 {
 	struct node *child;
@@ -1076,7 +1075,6 @@ static void check_obsolete_chosen_interrupt_controller(struct check *c,
 	if (node != dt)
 		return;
 
-
 	chosen = get_node_by_path(dt, "/chosen");
 	if (!chosen)
 		return;
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 6d667701ab6..39c50a2c4fc 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -65,7 +65,6 @@ extern int auto_label_aliases;	/* auto generate labels -> aliases */
 
 typedef uint32_t cell_t;
 
-
 #define streq(a, b)	(strcmp((a), (b)) == 0)
 #define strstarts(s, prefix)	(strncmp((s), (prefix), strlen(prefix)) == 0)
 #define strprefixeq(a, n, b)	(strlen(b) == (n) && (memcmp(a, b, n) == 0))
@@ -92,7 +91,6 @@ struct data {
 	struct marker *markers;
 };
 
-
 #define empty_data ((struct data){ 0 /* all .members = 0 or NULL */ })
 
 #define for_each_marker(m) \
@@ -252,7 +250,6 @@ struct reserve_info *chain_reserve_entry(struct reserve_info *first,
 struct reserve_info *add_reserve_entry(struct reserve_info *list,
 				       struct reserve_info *new);
 
-
 struct dt_info {
 	unsigned int dtsflags;
 	struct reserve_info *reservelist;
diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
index 8d268fb785d..086c5abf10f 100644
--- a/scripts/dtc/flattree.c
+++ b/scripts/dtc/flattree.c
@@ -695,7 +695,6 @@ static struct property *flat_read_property(struct inbuf *dtbuf,
 	return build_property(name, val);
 }
 
-
 static struct reserve_info *flat_read_mem_reserve(struct inbuf *inb)
 {
 	struct reserve_info *reservelist = NULL;
@@ -724,7 +723,6 @@ static struct reserve_info *flat_read_mem_reserve(struct inbuf *inb)
 	return reservelist;
 }
 
-
 static char *nodename_from_path(const char *ppath, const char *cpath)
 {
 	int plen;
@@ -806,7 +804,6 @@ static struct node *unflatten_tree(struct inbuf *dtbuf,
 	return node;
 }
 
-
 struct dt_info *dt_from_blob(const char *fname)
 {
 	FILE *f;
diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index 63eaf57f43a..d65656aaa8b 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -421,7 +421,6 @@ static const struct fdt_property *fdt_get_property_namelen_(const void *fdt,
 	return NULL;
 }
 
-
 const struct fdt_property *fdt_get_property_namelen(const void *fdt,
 						    int offset,
 						    const char *name,
@@ -439,7 +438,6 @@ const struct fdt_property *fdt_get_property_namelen(const void *fdt,
 					 NULL);
 }
 
-
 const struct fdt_property *fdt_get_property(const void *fdt,
 					    int nodeoffset,
 					    const char *name, int *lenp)
diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
index d706f85962b..16ec53e78b8 100644
--- a/scripts/dtc/libfdt/libfdt.h
+++ b/scripts/dtc/libfdt/libfdt.h
@@ -1162,7 +1162,6 @@ int fdt_address_cells(const void *fdt, int nodeoffset);
  */
 int fdt_size_cells(const void *fdt, int nodeoffset);
 
-
 /**********************************************************************/
 /* Write-in-place functions                                           */
 /**********************************************************************/
@@ -1696,7 +1695,6 @@ static inline int fdt_setprop_cell(void *fdt, int nodeoffset, const char *name,
 #define fdt_setprop_string(fdt, nodeoffset, name, str) \
 	fdt_setprop((fdt), (nodeoffset), (name), (str), strlen(str)+1)
 
-
 /**
  * fdt_setprop_empty - set a property to an empty value
  * @fdt: pointer to the device tree blob
diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
index 6e4c367f54b..ba06ef348be 100644
--- a/scripts/dtc/livetree.c
+++ b/scripts/dtc/livetree.c
@@ -631,7 +631,6 @@ uint32_t guess_boot_cpuid(struct node *tree)
 	if (!cpus)
 		return 0;
 
-
 	bootcpu = cpus->children;
 	if (!bootcpu)
 		return 0;
diff --git a/scripts/dtc/srcpos.c b/scripts/dtc/srcpos.c
index c2978611450..0ad89e2af60 100644
--- a/scripts/dtc/srcpos.c
+++ b/scripts/dtc/srcpos.c
@@ -33,7 +33,6 @@ struct search_path {
 /* This is the list of directories that we search for source files */
 static struct search_path *search_path_head, **search_path_tail;
 
-
 static char *get_dirname(const char *path)
 {
 	const char *slash = strrchr(path, '/');
@@ -56,7 +55,6 @@ struct srcfile_state *current_srcfile; /* = NULL */
 #define MAX_SRCFILE_DEPTH     (100)
 static int srcfile_depth; /* = 0 */
 
-
 /**
  * Try to open a file in a given directory.
  *
@@ -250,7 +248,6 @@ srcpos_string(struct srcpos *pos)
 	if (pos->file && pos->file->name)
 		fname = pos->file->name;
 
-
 	if (pos->first_line != pos->last_line)
 		xasprintf(&pos_str, "%s:%d.%d-%d.%d", fname,
 			  pos->first_line, pos->first_column,
diff --git a/scripts/dtc/srcpos.h b/scripts/dtc/srcpos.h
index 5db32a723e1..fcd9937a911 100644
--- a/scripts/dtc/srcpos.h
+++ b/scripts/dtc/srcpos.h
@@ -95,7 +95,6 @@ struct srcpos {
 		}								\
 	} while (0)
 
-
 /*
  * Fictional source position used for IR nodes that are
  * created without otherwise knowing a true source position.
diff --git a/scripts/dtc/treesource.c b/scripts/dtc/treesource.c
index b36cb41902a..8c8b914698d 100644
--- a/scripts/dtc/treesource.c
+++ b/scripts/dtc/treesource.c
@@ -262,7 +262,6 @@ static void write_tree_source_node(FILE *f, struct node *tree, int level)
 	fprintf(f, "};\n");
 }
 
-
 void dt_to_source(FILE *f, struct dt_info *dti)
 {
 	struct reserve_info *re;
diff --git a/scripts/dtc/util.c b/scripts/dtc/util.c
index 9953c32a024..23334d39bb6 100644
--- a/scripts/dtc/util.c
+++ b/scripts/dtc/util.c
@@ -325,7 +325,6 @@ int utilfdt_write_err(const char *filename, const void *blob)
 	return ret < 0 ? -ret : 0;
 }
 
-
 int utilfdt_write(const char *filename, const void *blob)
 {
 	int ret = utilfdt_write_err(filename, blob);
diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 2ec7419301d..aee993a778f 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -360,10 +360,8 @@ void init_right_tree(void)
 	gtk_tree_selection_set_mode(sel, GTK_SELECTION_SINGLE);
 }
 
-
 /* Utility Functions */
 
-
 static void text_insert_help(struct menu *menu)
 {
 	GtkTextBuffer *buffer;
@@ -388,7 +386,6 @@ static void text_insert_help(struct menu *menu)
 	str_free(&help);
 }
 
-
 static void text_insert_msg(const char *title, const char *message)
 {
 	GtkTextBuffer *buffer;
@@ -409,7 +406,6 @@ static void text_insert_msg(const char *title, const char *message)
 					 NULL);
 }
 
-
 /* Main Windows Callbacks */
 
 void on_save_activate(GtkMenuItem * menuitem, gpointer user_data);
@@ -457,13 +453,11 @@ gboolean on_window1_delete_event(GtkWidget * widget, GdkEvent * event,
 	return FALSE;
 }
 
-
 void on_window1_destroy(GtkObject * object, gpointer user_data)
 {
 	gtk_main_quit();
 }
 
-
 void
 on_window1_size_request(GtkWidget * widget,
 			GtkRequisition * requisition, gpointer user_data)
@@ -483,10 +477,8 @@ on_window1_size_request(GtkWidget * widget,
 	gtk_paned_set_position(GTK_PANED(vpaned), 2 * h / 3);
 }
 
-
 /* Menu & Toolbar Callbacks */
 
-
 static void
 load_filename(GtkFileSelection * file_selector, gpointer user_data)
 {
@@ -520,14 +512,12 @@ void on_load1_activate(GtkMenuItem * menuitem, gpointer user_data)
 	gtk_widget_show(fs);
 }
 
-
 void on_save_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	if (conf_write(NULL))
 		text_insert_msg("Error", "Unable to save configuration !");
 }
 
-
 static void
 store_filename(GtkFileSelection * file_selector, gpointer user_data)
 {
@@ -561,14 +551,12 @@ void on_save_as1_activate(GtkMenuItem * menuitem, gpointer user_data)
 	gtk_widget_show(fs);
 }
 
-
 void on_quit1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	if (!on_window1_delete_event(NULL, NULL, NULL))
 		gtk_widget_destroy(GTK_WIDGET(main_wnd));
 }
 
-
 void on_show_name1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkTreeViewColumn *col;
@@ -579,7 +567,6 @@ void on_show_name1_activate(GtkMenuItem * menuitem, gpointer user_data)
 		gtk_tree_view_column_set_visible(col, show_name);
 }
 
-
 void on_show_range1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkTreeViewColumn *col;
@@ -597,7 +584,6 @@ void on_show_range1_activate(GtkMenuItem * menuitem, gpointer user_data)
 
 }
 
-
 void on_show_data1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkTreeViewColumn *col;
@@ -608,7 +594,6 @@ void on_show_data1_activate(GtkMenuItem * menuitem, gpointer user_data)
 		gtk_tree_view_column_set_visible(col, show_value);
 }
 
-
 void
 on_set_option_mode1_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
@@ -617,7 +602,6 @@ on_set_option_mode1_activate(GtkMenuItem *menuitem, gpointer user_data)
 	display_tree(&rootmenu);	/* instead of update_tree to speed-up */
 }
 
-
 void
 on_set_option_mode2_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
@@ -626,7 +610,6 @@ on_set_option_mode2_activate(GtkMenuItem *menuitem, gpointer user_data)
 	display_tree(&rootmenu);	/* instead of update_tree to speed-up */
 }
 
-
 void
 on_set_option_mode3_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
@@ -635,7 +618,6 @@ on_set_option_mode3_activate(GtkMenuItem *menuitem, gpointer user_data)
 	display_tree(&rootmenu);	/* instead of update_tree to speed-up */
 }
 
-
 void on_introduction1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkWidget *dialog;
@@ -666,7 +648,6 @@ void on_introduction1_activate(GtkMenuItem * menuitem, gpointer user_data)
 	gtk_widget_show_all(dialog);
 }
 
-
 void on_about1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkWidget *dialog;
@@ -684,7 +665,6 @@ void on_about1_activate(GtkMenuItem * menuitem, gpointer user_data)
 	gtk_widget_show_all(dialog);
 }
 
-
 void on_license1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkWidget *dialog;
@@ -703,7 +683,6 @@ void on_license1_activate(GtkMenuItem * menuitem, gpointer user_data)
 	gtk_widget_show_all(dialog);
 }
 
-
 void on_back_clicked(GtkButton * button, gpointer user_data)
 {
 	enum prop_type ptype;
@@ -718,13 +697,11 @@ void on_back_clicked(GtkButton * button, gpointer user_data)
 		gtk_widget_set_sensitive(back_btn, FALSE);
 }
 
-
 void on_load_clicked(GtkButton * button, gpointer user_data)
 {
 	on_load1_activate(NULL, user_data);
 }
 
-
 void on_single_clicked(GtkButton * button, gpointer user_data)
 {
 	view_mode = SINGLE_VIEW;
@@ -733,7 +710,6 @@ void on_single_clicked(GtkButton * button, gpointer user_data)
 	display_tree_part();
 }
 
-
 void on_split_clicked(GtkButton * button, gpointer user_data)
 {
 	gint w, h;
@@ -749,7 +725,6 @@ void on_split_clicked(GtkButton * button, gpointer user_data)
 	gtk_widget_set_sensitive(back_btn, FALSE);
 }
 
-
 void on_full_clicked(GtkButton * button, gpointer user_data)
 {
 	view_mode = FULL_VIEW;
@@ -760,19 +735,16 @@ void on_full_clicked(GtkButton * button, gpointer user_data)
 	gtk_widget_set_sensitive(back_btn, FALSE);
 }
 
-
 void on_collapse_clicked(GtkButton * button, gpointer user_data)
 {
 	gtk_tree_view_collapse_all(GTK_TREE_VIEW(tree2_w));
 }
 
-
 void on_expand_clicked(GtkButton * button, gpointer user_data)
 {
 	gtk_tree_view_expand_all(GTK_TREE_VIEW(tree2_w));
 }
 
-
 /* CTree Callbacks */
 
 /* Change hex/int/string value in the cell */
@@ -874,7 +846,6 @@ static gint column2index(GtkTreeViewColumn * column)
 	return -1;
 }
 
-
 /* User click: update choice (full) or goes down (single) */
 gboolean
 on_treeview2_button_press_event(GtkWidget * widget,
@@ -976,7 +947,6 @@ on_treeview2_key_press_event(GtkWidget * widget,
 	return FALSE;
 }
 
-
 /* Row selection changed: update help */
 void
 on_treeview2_cursor_changed(GtkTreeView * treeview, gpointer user_data)
@@ -992,7 +962,6 @@ on_treeview2_cursor_changed(GtkTreeView * treeview, gpointer user_data)
 	}
 }
 
-
 /* User click: display sub-tree in the right frame. */
 gboolean
 on_treeview1_button_press_event(GtkWidget * widget,
@@ -1032,7 +1001,6 @@ on_treeview1_button_press_event(GtkWidget * widget,
 	return FALSE;
 }
 
-
 /* Fill a row of strings */
 static gchar **fill_row(struct menu *menu)
 {
@@ -1157,7 +1125,6 @@ static gchar **fill_row(struct menu *menu)
 	return row;
 }
 
-
 /* Set the node content with a row of strings */
 static void set_node(GtkTreeIter * node, struct menu *menu, gchar ** row)
 {
@@ -1193,7 +1160,6 @@ static void set_node(GtkTreeIter * node, struct menu *menu, gchar ** row)
 	g_object_unref(pix);
 }
 
-
 /* Add a node to the tree */
 static void place_node(struct menu *menu, char **row)
 {
@@ -1204,7 +1170,6 @@ static void place_node(struct menu *menu, char **row)
 	set_node(node, menu, row);
 }
 
-
 /* Find a node in the GTK+ tree */
 static GtkTreeIter found;
 
@@ -1240,7 +1205,6 @@ GtkTreeIter *gtktree_iter_find_node(GtkTreeIter * parent,
 	return NULL;
 }
 
-
 /*
  * Update the tree by adding/removing entries
  * Does not change other nodes
@@ -1329,7 +1293,6 @@ static void update_tree(struct menu *src, GtkTreeIter * dst)
 	}
 }
 
-
 /* Display the whole tree (single/split/full view) */
 static void display_tree(struct menu *menu)
 {
@@ -1439,7 +1402,6 @@ void fixup_rootmenu(struct menu *menu)
 	}
 }
 
-
 /* Main */
 int main(int ac, char *av[])
 {
diff --git a/scripts/kconfig/list.h b/scripts/kconfig/list.h
index 06e8d555d8b..9f1d16a43c2 100644
--- a/scripts/kconfig/list.h
+++ b/scripts/kconfig/list.h
@@ -20,12 +20,10 @@
 	const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
 	(type *)( (char *)__mptr - offsetof(type,member) );})
 
-
 struct list_head {
 	struct list_head *next, *prev;
 };
 
-
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
 #define LIST_HEAD(name) \
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 9eb7c837cd8..2daf47f57cc 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -131,7 +131,6 @@ static inline tristate sym_get_tristate_value(struct symbol *sym)
 	return sym->curr.tri;
 }
 
-
 static inline struct symbol *sym_get_choice_value(struct symbol *sym)
 {
 	return (struct symbol *)sym->curr.val;
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 68b565e3c49..7675c4702ac 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -213,7 +213,6 @@ int dialog_yesno(const char *title, const char *prompt, int height, int width);
 int dialog_msgbox(const char *title, const char *prompt, int height,
 		  int width, int pause);
 
-
 typedef void (*update_text_fn)(char *buf, size_t start, size_t end, void
 			       *_data);
 int dialog_textbox(const char *title, char *tbuf, int initial_height,
diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
index 4e339b12664..12e68c0fb64 100644
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -33,7 +33,6 @@ static void refresh_text_box(WINDOW *dialog, WINDOW *box, int boxh, int boxw,
 	wrefresh(dialog);
 }
 
-
 /*
  * Display text from a file in a dialog box.
  *
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 4cf15d449c0..0fe7f3255af 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -853,7 +853,6 @@ struct gstr get_relations_str(struct symbol **sym_arr, struct list_head *head)
 	return res;
 }
 
-
 void menu_get_ext_help(struct menu *menu, struct gstr *help)
 {
 	struct symbol *sym = menu->sym;
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 5cbdb92e11b..ca878212f0a 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -687,7 +687,6 @@ static int do_exit(void)
 	return 0;
 }
 
-
 static void search_conf(void)
 {
 	struct symbol **sym_arr;
@@ -731,7 +730,6 @@ again:
 	str_free(&title);
 }
 
-
 static void build_conf(struct menu *menu)
 {
 	struct symbol *sym;
diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
index 88874acfda3..2a3b853e7ea 100644
--- a/scripts/kconfig/nconf.gui.c
+++ b/scripts/kconfig/nconf.gui.c
@@ -143,7 +143,6 @@ void set_colors(void)
 	}
 }
 
-
 /* this changes the windows attributes !!! */
 void print_in_middle(WINDOW *win,
 		int starty,
@@ -154,7 +153,6 @@ void print_in_middle(WINDOW *win,
 {      int length, x, y;
 	float temp;
 
-
 	if (win == NULL)
 		win = stdscr;
 	getyx(win, y, x);
@@ -256,7 +254,6 @@ int btn_dialog(WINDOW *main_window, const char *msg, int btn_num, ...)
 	int i, x, y;
 	int res = -1;
 
-
 	va_start(ap, btn_num);
 	for (i = 0; i < btn_num; i++) {
 		btn = va_arg(ap, char *);
@@ -280,7 +277,6 @@ int btn_dialog(WINDOW *main_window, const char *msg, int btn_num, ...)
 	y = (getmaxy(stdscr)-(msg_lines+4))/2;
 	x = (getmaxx(stdscr)-(total_width+4))/2;
 
-
 	/* create the windows */
 	if (btn_num > 0)
 		win_rows = msg_lines+4;
@@ -315,7 +311,6 @@ int btn_dialog(WINDOW *main_window, const char *msg, int btn_num, ...)
 	set_menu_mark(menu, "");
 	post_menu(menu);
 
-
 	touchwin(win);
 	refresh_all_windows(main_window);
 	while ((res = wgetch(win))) {
-- 
2.43.0

